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
        
        rootView.seatOptionDidSelect = { [weak self] selectedTitle in
            guard let self else { return }
            
            if selectedTitle == "콘센트석" {
                applyOutletFilter()
            } else {
                resetFilter()
            }
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
        
        cell.dataBind(train)
        
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
    
    func applyOutletFilter() {
        filteredTrainList = trainList.filter { train in
            return train.canSelectOutletSeat
        }

        rootView.tableView.reloadData()
    }
    
    func resetFilter() {
        filteredTrainList = trainList
        rootView.tableView.reloadData()
    }
}
