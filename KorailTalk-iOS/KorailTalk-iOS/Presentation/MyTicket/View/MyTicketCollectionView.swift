//
//  MyTicketCollectionView.swift.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketCollectionView: BaseUIView {
    
    // MARK: - Property
    
    private var reservations: [Reservation] = []
    
    // MARK: - UI Component
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
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
        addSubviews(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setRegister() {
        collectionView.register(MyTicketCollectionViewCell.self,
                                forCellWithReuseIdentifier: MyTicketCollectionViewCell.identifier)
        
        collectionView.register(MyTicketCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MyTicketCollectionHeaderView.identifier)
    }
    
    // MARK: - Publice Method
    
    func configure(with reservations: [Reservation]) {
        self.reservations = reservations
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MyTicketCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyTicketCollectionViewCell.identifier,
            for: indexPath
        ) as? MyTicketCollectionViewCell else { return UICollectionViewCell() }
        
        let reservation = reservations[indexPath.item]
        let train = reservation.train
        
        let randomCarNumber = Int.random(in: 1...18)
        
        let seatNames = reservation.seats.map { seat -> String in
            let letter = (seat.number % 2 == 1) ? "A" : "B"
            return "\(seat.number)\(letter)"
        }
        
        let cellModel = ReservationModel(
            date: train.time.departureTime.toKoreanFullDateString,
            trainName: "[\(train.name)]",
            passengerCount: "어른 \(reservation.seats.count)명",
            departureTime: train.time.departureTime.toTimeString,
            destinationTime: train.time.arrivalTime.toTimeString,
            carNumber: randomCarNumber,
            seatNames: seatNames
        )
        
        cell.configure(with: cellModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MyTicketCollectionHeaderView.identifier,
                for: indexPath
            ) as? MyTicketCollectionHeaderView else { return UICollectionReusableView() }
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyTicketCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 26, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 52)
    }
}
