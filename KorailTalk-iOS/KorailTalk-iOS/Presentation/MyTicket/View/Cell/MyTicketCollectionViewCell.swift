//
//  MyTicketCollectionViewCell.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketCollectionViewCell: BaseUICollectionViewCell {
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    private let trainLabel = UILabel()
    
    private let informationStackView = UIStackView()
    private let departureStationLabel = StationTag(type: .large, title: "용산")
    private let departureTimeLabel = UILabel()
    private let arrowLabel = UILabel()
    private let destinationStationLabel = StationTag(type: .large, title: "순천")
    private let destinationTimeLabel = UILabel()
    
    private let seatTypeLabel = UILabel()
    
    private let ticketDetailView = TicketDetailView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        contentView.backgroundColor = .neutral100
        
        dateLabel.do {
            $0.font = .pretendard(.header3)
            $0.textColor = .secondary700
        }
        
        trainLabel.do {
            $0.font = .pretendard(.header3)
            $0.textColor = .neutral900
        }
        
        seatTypeLabel.do {
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }
        
        informationStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 8
        }
        
        departureTimeLabel.do {
            $0.font = .pretendard(.body4)
            $0.textColor = .neutral900
        }
        
        arrowLabel.do {
            $0.font = .pretendard(.body4)
            $0.text = "→"
            $0.textColor = .neutral900
        }
        
        destinationTimeLabel.do {
            $0.font = .pretendard(.body4)
            $0.textColor = .neutral900
        }
        
        ticketDetailView.do {
            $0.layer.cornerRadius = 28
            $0.clipsToBounds = true
        }
    }
    
    override func setUI() {
        contentView.addSubviews(dateLabel, trainLabel, seatTypeLabel,
                                informationStackView, ticketDetailView)
        
        informationStackView.addArrangedSubviews(departureStationLabel, departureTimeLabel,
                                                 arrowLabel, destinationStationLabel, destinationTimeLabel)
    }
    
    override func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        trainLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview()
        }
        
        seatTypeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(trainLabel.snp.centerY)
        }
        
        informationStackView.snp.makeConstraints {
            $0.top.equalTo(trainLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        
        ticketDetailView.snp.makeConstraints {
            $0.top.equalTo(informationStackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Method
    
    func configure(with model: ReservationModel) {
        dateLabel.text = model.date
        trainLabel.text = model.trainName
        seatTypeLabel.text = model.passengerCount
        departureTimeLabel.text = model.departureTime
        destinationTimeLabel.text = model.destinationTime
        
        ticketDetailView.configure(carNumber: model.carNumber, seats: model.seatNames)
    }
}
