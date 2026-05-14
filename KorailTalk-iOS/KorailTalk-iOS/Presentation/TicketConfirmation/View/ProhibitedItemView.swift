//
//  ProhibitedItemView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

import SnapKit
import Then

final class ProhibitedItemView: BaseUIView {
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let captionLabel = UILabel()
    private let grayLineView = UIView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        titleLabel.do {
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }
        
        subtitleLabel.do {
            $0.font = .pretendard(.caption1)
            $0.textColor = .surfaceDisabled
            $0.numberOfLines = 2
        }
        
        captionLabel.do {
            $0.font = .pretendard(.caption3)
            $0.textColor = .neutral900
        }
        
        grayLineView.do {
            $0.backgroundColor = .neutral300
        }
    }
    
    override func setUI() {
        addSubviews(iconImageView, titleLabel, subtitleLabel, captionLabel, grayLineView)
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(53)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        captionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(6)
        }
        
        grayLineView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(iconImageView.snp.bottom).offset(16)
            $0.height.equalTo(0.5)
        }
    }
    
    // MARK: - Public Methods
    
    func configure(prohibitedItem: ProhibitedItem) {
        iconImageView.image = prohibitedItem.iconImage
        titleLabel.text = prohibitedItem.title
        subtitleLabel.text = prohibitedItem.subtitle
        
        if let caption = prohibitedItem.caption {
            captionLabel.text = caption
            captionLabel.isHidden = false
        } else {
            captionLabel.isHidden = true
        }
    }
}
