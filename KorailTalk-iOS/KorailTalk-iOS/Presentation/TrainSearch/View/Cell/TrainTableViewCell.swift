//
//  TrainTableViewCell.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/13/26.
//

import UIKit

import SnapKit
import Then

final class TrainTableViewCell: BaseTableViewCell {
    
    // MARK: - Property
    
    var standardButtonDidTap: (() -> Void)?
    var specialButtonDidTap: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    
    private let trainNameLabel = UILabel()
    
    private let timeStackView = UIStackView()
    private let departureTimeLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    private let durationLabel = UILabel()
    
    private let benefitStackView = UIStackView()
    private let benefitImageView = UIImageView()
    private let benefitLabel = UILabel()
    
    private let fareButtonStackView = UIStackView()
    private let standardButton = FareOptionButton(fareOption: FareOption(seatType: .standard, status: .available, fare: 34600))
    private let specialButton = FareOptionButton(fareOption: FareOption(seatType: .special, status: .available, fare: 70000))
    
    // MARK: - Custom Methods
    
    override func setUI() {
        benefitStackView.addArrangedSubviews(benefitImageView, benefitLabel)
        timeStackView.addArrangedSubviews(departureTimeLabel, arrowImageView, arrivalTimeLabel)
        fareButtonStackView.addArrangedSubviews(standardButton, specialButton)
        
        contentView.addSubview(containerView)
        containerView.addSubviews(trainNameLabel, timeStackView, durationLabel, benefitStackView, fareButtonStackView)
    }
    
    override func setStyle() {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 26
            $0.layer.masksToBounds = true
        }
        
        trainNameLabel.do {
            $0.textColor = .secondary700
            $0.textAlignment = .left
            $0.font = .pretendard(.body3)
        }
        
        timeStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        departureTimeLabel.do {
            $0.textColor = .neutral900
            $0.font = .pretendard(.body1)
            $0.adjustsFontForContentSizeCategory = false
        }
        
        arrivalTimeLabel.do {
            $0.textColor = .neutral900
            $0.font = .pretendard(.body1)
            $0.adjustsFontForContentSizeCategory = false
        }
        
        durationLabel.do {
            $0.textColor = .neutral500
            $0.font = .pretendard(.caption1)
        }
        
        arrowImageView.do {
            $0.image = .icArrow
        }
        
        benefitStackView.do {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        benefitImageView.do {
            $0.image = .icMoney
            $0.contentMode = .scaleAspectFit
        }
        
        benefitLabel.do {
            $0.font = .pretendard(.caption2)
            $0.textColor = .neutral700
            $0.text = "5% 적립"
        }
        
        fareButtonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
    }
    
    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.horizontalEdges.equalToSuperview().inset(16.adjustedW)
        }
        
        trainNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13.adjustedW)
            $0.top.equalToSuperview().inset(14)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.equalTo(15.adjustedW)
            $0.height.equalTo(12.adjustedW)
        }
        
        timeStackView.snp.makeConstraints {
            $0.top.equalTo(trainNameLabel.snp.bottom).offset(14)
            $0.leading.equalTo(trainNameLabel)
            $0.height.equalTo(16)
        }
        
        durationLabel.snp.makeConstraints {
            $0.top.equalTo(timeStackView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalTo(trainNameLabel)
        }
        
        benefitStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(13.adjustedW)
        }
        
        fareButtonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.width.equalTo(170.adjustedW)
            $0.trailing.equalToSuperview().inset(13.adjustedW)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    override func setAddTarget() {
        standardButton.addTarget(self, action: #selector(standardButtonTapped), for: .touchUpInside)
        specialButton.addTarget(self, action: #selector(specialButtonTapped), for: .touchUpInside)
    }
        
    // MARK: - Actions
    
    @objc
    private func standardButtonTapped() {
        standardButtonDidTap?()
    }

    @objc
    private func specialButtonTapped() {
        specialButtonDidTap?()
    }
    
}

extension TrainTableViewCell {
    func dataBind(_ data: TrainModel, showBenefit: Bool) {
        trainNameLabel.text = data.trainInfo.name
        departureTimeLabel.text = data.departureTime
        arrivalTimeLabel.text = data.arrivalTime
        durationLabel.text = "약 \(data.durationTime) 소요"
        standardButton.updateConfig(fare: data.fareInfo.general.price)
        
        if let specialFare = data.fareInfo.special {
            specialButton.updateConfig(fare: specialFare.price)
        } else {
            specialButton.updateSoldOut()
        }
        
        benefitStackView.isHidden = !showBenefit
    }
}
