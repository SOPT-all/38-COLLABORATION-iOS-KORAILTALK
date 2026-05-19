//
//  MyTicketCollectionView.swift.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

struct TicketDummyModel {
    let date: String
    let trainName: String
    let passengerCount: String
    let departureStation: String
    let departureTime: String
    let destinationStation: String
    let destinationTime: String
}

private var ticketList: [TicketDummyModel] = [
    TicketDummyModel(
        date: "2026년 5월 5일 (월)",
        trainName: "[무궁화호 1248]",
        passengerCount: "어른 2명",
        departureStation: "용산",
        departureTime: "15: 04",
        destinationStation: "순천",
        destinationTime: "19: 55"
    ),
    TicketDummyModel(
        date: "2026년 5월 15일 (금)",
        trainName: "[KTX 021]",
        passengerCount: "어른 1명",
        departureStation: "서울",
        departureTime: "09: 30",
        destinationStation: "부산",
        destinationTime: "12: 15"
    )
]

final class MyTicketCollectionView: BaseUIView {
    
    // MARK: - UI Components
    
    private let gradientView = GradientGuideView(type: .myTicket)
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .neutral100
        
        collectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 26
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setUI() {
        addSubviews(gradientView, collectionView)
    }
    
    override func setLayout() {
        gradientView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(gradientView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Private Method
    
    private func setRegister() {
        collectionView.register(MyTicketCollectionViewCell.self,
            forCellWithReuseIdentifier: MyTicketCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension MyTicketCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyTicketCollectionViewCell.identifier,
            for: indexPath
        ) as? MyTicketCollectionViewCell else { return UICollectionViewCell() }
        
        let data = ticketList[indexPath.item]
        
        cell.configure(
            date: data.date,
            trainName: data.trainName,
            passengerCount: data.passengerCount,
            departureStation: data.departureStation,
            departureTime: data.departureTime,
            destinationStation: data.destinationStation,
            destinationTime: data.destinationTime
        )
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyTicketCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
