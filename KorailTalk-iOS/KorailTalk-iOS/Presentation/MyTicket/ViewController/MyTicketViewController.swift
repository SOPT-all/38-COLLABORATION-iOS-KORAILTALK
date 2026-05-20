//
//  MyTicketViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    private let trainService: TrainServiceProtocol
    private var reservations: [Reservation] = []
    
    // MARK: - Initializer
    
    init(trainService: TrainServiceProtocol = TrainService()) {
        self.trainService = trainService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let myTicketCollectionView = MyTicketCollectionView()
    
    // MARK: - Lify Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMyTickets()
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        navigationBar.configure(title: "나의 티켓", showsRefreshButton: false)
        view.backgroundColor = .neutral100
    }
    
    override func setUI() {
        view.addSubview(myTicketCollectionView)
    }
    
    override func setLayout() {
        myTicketCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
    }
}

// MARK: - API Calls

private extension MyTicketViewController {
    func fetchMyTickets() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let fetchedData = try await fetchMyReservations(userId: 1)
                reservations = fetchedData
                myTicketCollectionView.configure(with: fetchedData)
                
            } catch {
                print("🚨 나의 티켓 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMyReservations(userId: Int) async throws -> [Reservation] {
        try await withCheckedThrowingContinuation { continuation in
            trainService.fetchMyReservations(userId: userId) { result in
                continuation.resume(with: result)
            }
        }
    }
}
