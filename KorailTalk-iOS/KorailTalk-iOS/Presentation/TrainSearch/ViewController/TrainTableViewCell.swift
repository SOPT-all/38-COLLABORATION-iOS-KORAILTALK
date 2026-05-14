//
//  TrainTableViewCell.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/13/26.
//

import UIKit

import SnapKit
import Then

final class TrainTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let trainNameLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let durationLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let benefitImageView = UIImageView()
    private let benefitLabel = UILabel()
    private let benefitStackView = UIStackView()
    private let containerVeiw = UIView()
    
    private let standardButton = FareOptionButton(fareOption: FareOption(seatType: .standard, status: .available, fare: 34600))
    private let specialButton = FareOptionButton(fareOption: FareOption(seatType: .special, status: .available, fare: 70000))
    private let fareButtonStackView = UIStackView()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Methods
    
    private func setUI() {
        benefitStackView.addArrangedSubviews(benefitImageView, benefitLabel)
        
        fareButtonStackView.addArrangedSubviews(standardButton, specialButton)

        contentView.addSubview(containerVeiw)
        
        containerVeiw.addSubviews(trainNameLabel, departureTimeLabel,  arrowImageView, arrivalTimeLabel, durationLabel, benefitStackView, fareButtonStackView)
    }
    
    private func setStyle() {
        trainNameLabel.do {
            $0.textColor = .secondary700
            $0.textAlignment = .left
            $0.font = .pretendard(.body3)
        }
        
        departureTimeLabel.do {
            $0.textColor = .neutral900
            $0.textAlignment = .left
            $0.font = .pretendard(.body1)
        }
        
        arrivalTimeLabel.do {
            $0.textColor = .neutral900
            $0.textAlignment = .left
            $0.font = .pretendard(.body1)
        }
        
        durationLabel.do {
            $0.textColor = .neutral500
            $0.textAlignment = .left
            $0.font = .pretendard(.caption1)
        }
        
        arrowImageView.do {
            $0.image = .icArrow
        }
        
        benefitStackView.do {
            $0.axis = .horizontal
            $0.alignment = .leading
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
            $0.alignment = .fill
        }
        
        backgroundColor = .clear
        containerVeiw.layer.cornerRadius = 26
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .clear
        containerVeiw.backgroundColor = .white
    }
    
    private func setLayout() {
        containerVeiw.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20))
        }
        trainNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.top.equalToSuperview().offset(14)
        }
        
        departureTimeLabel.snp.makeConstraints {
            $0.top.equalTo(trainNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(13)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(departureTimeLabel)
            $0.leading.equalTo(departureTimeLabel.snp.trailing).offset(8)
        }
        
        arrivalTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(departureTimeLabel)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(8)
        }
        
        durationLabel.snp.makeConstraints {
            $0.top.equalTo(arrivalTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(19)
        }
        
        benefitStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        fareButtonStackView.snp.makeConstraints {
            $0.top.equalTo(benefitStackView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(19)
        }
        
    }
    
    // MARK: - Public Methods
    
    func configure(benefitText: String?) {
        if let benefitText {
            benefitLabel.text = benefitText
            benefitStackView.isHidden = false
        } else {
            benefitStackView.isHidden = true
        }
    }
}

// TODO: - 서버 통신 API 연결 및 데이터 바인딩 로직 구현
// TODO: - 버튼 클릭 액션 처리를 위한 클로저 또는 Delegate 패턴 추가
