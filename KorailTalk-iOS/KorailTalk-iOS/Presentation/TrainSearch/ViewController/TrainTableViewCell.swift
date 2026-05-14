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
    
    private let trainNameLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let durationLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let benefitImageView = UIImageView()
    private let benefitLabel = UILabel()
    private let benefitStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUI() {
        benefitStackView.addArrangedSubviews(benefitImageView, benefitLabel)
        contentView.addSubviews(trainNameLabel, departureTimeLabel, arrowImageView, arrivalTimeLabel, durationLabel,  benefitStackView)
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
        
        benefitStackView.do{
            $0.axis = .horizontal
            $0.alignment = .leading
            $0.spacing = 3
        }
        
        benefitImageView.do{
            $0.image = .icMoney
            $0.contentMode = .scaleAspectFit
        }
        
        benefitLabel.do{
            $0.font = .pretendard(.caption2)
            $0.textColor = .neutral700
            $0.text = "5% 적립"
        }
    }
    
    private func setLayout() {
        trainNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.top.equalToSuperview().offset(14)
        }
        
        departureTimeLabel.snp.makeConstraints {
            $0.top.equalTo(trainNameLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(13)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(departureTimeLabel)
            $0.leading.equalTo(departureTimeLabel.snp.trailing).offset(8)
        }
        
        arrivalTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(departureTimeLabel)
            $0.leading.equalTo(departureTimeLabel.snp.trailing).offset(8)
        }
        
        durationLabel.snp.makeConstraints {
            $0.top.equalTo(arrivalTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(13)
        }
        
        benefitStackView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(13)
        }
    }
    
    func configure(benefitText: String?) {
        if let benefitText {
            benefitLabel.text = benefitText
            benefitStackView.isHidden = false
        } else {
            benefitStackView.isHidden = true
        }
    }
}
