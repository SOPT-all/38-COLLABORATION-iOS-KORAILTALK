//
//  TrainSearchViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit

final class TrainSearchViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    private let trainService: TrainServiceProtocol
    private var trainList: [TrainModel] = []
    private var filteredTrainList: [TrainModel] = []
    
    private var currentTrainType: String = "전체"
    private var currentSeatOption: String = "일반석"
    
    // MARK: - UI Components
    
    private let rootView = TrainSearchView()
    
    // MARK: - Initializer
    
    init(trainService: TrainServiceProtocol = TrainService()) {
        self.trainService = trainService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredTrainList = trainList
        register()
        fetchTrainList()
    }
    
    override func setUI() {
        view.addSubviews(rootView)
        navigationBar.configure(title: "승차권 조회")
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.trainTypeDidSelect = { [weak self] selectedType in
            guard let self else { return }
            currentTrainType = selectedType
            applyFilters()
        }
        
        rootView.seatOptionDidSelect = { [weak self] selectedOption in
            guard let self else { return }
            
            currentSeatOption = selectedOption
            applyFilters()
        }
    }
    
    private func register() {
        rootView.tableView.register(TrainTableViewCell.self, forCellReuseIdentifier: TrainTableViewCell.identifier)
    }
}

extension TrainSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TrainSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TrainTableViewCell.identifier,
            for: indexPath) as? TrainTableViewCell else { return UITableViewCell() }
        
        let train = filteredTrainList[indexPath.row]
        let shouldShowBenefit = (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
        
        cell.dataBind(train, showBenefit: shouldShowBenefit)
        
        cell.standardButtonDidTap = { [weak self] in
            self?.navigationController?.pushViewController(
                SeatSelectionViewController(
                    scheduleId: train.scheduleId,
                    selectedFare: train.fareInfo.general
                ),
                animated: true
            )
        }
        
        cell.specialButtonDidTap = { [weak self] in
            guard let specialFare = train.fareInfo.special else { return }
            
            self?.navigationController?.pushViewController(
                SeatSelectionViewController(
                    scheduleId: train.scheduleId,
                    selectedFare: specialFare
                ),
                animated: true
            )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTrainList.count
    }
}

private extension TrainSearchViewController {
    func fetchTrainList() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let fetchedData = try await requestSchedules()
                
                trainList = fetchedData.map {
                    TrainModel(
                        scheduleId: $0.scheduleId,
                        trainInfo: $0.trainInfo,
                        fareInfo: $0.trainFare,
                        hasOutletSeat: true
                    )
                }
                
                resetFilter()
                
            } catch {
                print("🚨 열차 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func requestSchedules() async throws -> [ScheduleInfo] {
        try await withCheckedThrowingContinuation { continuation in
            trainService.fetchSchedules { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func applyFilters() {
        filteredTrainList = trainList.filter { train in
            let matchesTrainType: Bool
            if currentTrainType == "전체" {
                matchesTrainType = true
            } else {
                matchesTrainType = train.trainInfo.name.lowercased().contains(currentTrainType.lowercased())
            }
            
            let matchesSeatOption: Bool
            if currentSeatOption == "콘센트석" {
                matchesSeatOption = train.canSelectOutletSeat
            } else {
                matchesSeatOption = true
            }
            
            return matchesTrainType && matchesSeatOption
        }
        
        rootView.tableView.reloadData()
    }
    
    func resetFilter() {
        currentTrainType = "전체"
        currentSeatOption = "일반석"
        filteredTrainList = trainList
        rootView.tableView.reloadData()
    }
}
