//
//  TrainSearchView.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/15/26.
//
import UIKit

import SnapKit
import Then

final class TrainSearchView: BaseUIView {
    
    // MARK: - UI Components
    
    private let departureLabel = UILabel()
    private let arrivalLabel = UILabel()
    private let arrowImage = UIImageView()
    
    private let backButton = UIButton()
    private let nextButton = UIButton()
    private let dateLabel = UILabel()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .neutral100

        arrowImage.do {
            $0.image = .icArrowBlue
            $0.contentMode = .scaleAspectFit
        }
        
        departureLabel.do {
            $0.text = "용산"
            $0.font = .pretendard(.header1)
            $0.textColor = .secondary700
            $0.textAlignment = .center
        }
        
        arrivalLabel.do {
            $0.text = "순천"
            $0.font = .pretendard(.header1)
            $0.textColor = .secondary700
            $0.textAlignment = .center
        }
        
        dateLabel.do {
            $0.text = "2026년 5월 5일 (월)"
            $0.font = .pretendard(.body2)
            $0.textColor = .neutral900
        }
        
        backButton.do {
            $0.setImage(.icPrevious, for: .normal)
        }
        
        nextButton.do {
            $0.setImage(.icNext, for: .normal)
        }
    }
    
    override func setUI() {
        addSubviews(departureLabel, arrowImage, arrivalLabel, backButton, nextButton, dateLabel)
    }
    
    override func setLayout() {
        arrowImage.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.top.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
        }
        
        departureLabel.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(36)
            $0.centerY.equalTo(arrowImage)
            $0.trailing.equalTo(arrowImage.snp.leading).offset(-8)
        }
        
        arrivalLabel.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(36)
            $0.centerY.equalTo(arrowImage)
            $0.leading.equalTo(arrowImage.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(departureLabel.snp.bottom).offset(6.5)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(dateLabel.snp.leading).offset(-55)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(55)
        }
    }
}
