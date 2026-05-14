//
//  LuggageNoticeView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

import SnapKit
import Then

final class LuggageNoticeView: BaseUIView {
    
    // MARK: - UI Components
    
    private let titleStackView = UIStackView()
    private let noticeIconImageView = UIImageView()
    private let noticeTitleLabel = UILabel()
    
    private let noticeStackView = UIStackView()
    private let firstNoticeLabel = UILabel()
    private let secondNoticeLabel = UILabel()
    private let thirdNoticeLabel = UILabel()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .surfaceElevated
        
        titleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 7
        }
        
        noticeIconImageView.do {
            $0.image = .icExclamation
        }
        
        noticeTitleLabel.do {
            $0.text = "열차 내 물품 안내"
            $0.font = .pretendard(.caption1)
            $0.textColor = .surfaceDisabled
        }
        
        noticeStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
        }
        
        firstNoticeLabel.do {
            $0.text = "•  좌석·통로를 차지하지 않는 물품 2개까지 휴대 가능"
            $0.font = .pretendard(.caption2)
            $0.textColor = .surfaceDisabled
        }
        
        secondNoticeLabel.do {
            $0.text = "•  객실과 객실 사이 짐 보관함 또는 객실 내 선반에 보관"
            $0.font = .pretendard(.caption2)
            $0.textColor = .surfaceDisabled
        }
        
        thirdNoticeLabel.do {
            $0.text = "•  고객이 스스로 운반이 가능한 부피 수용"
            $0.font = .pretendard(.caption2)
            $0.textColor = .surfaceDisabled
        }
    }
    
    override func setUI() {
        titleStackView.addArrangedSubviews(noticeIconImageView, noticeTitleLabel)
        noticeStackView.addArrangedSubviews(firstNoticeLabel, secondNoticeLabel, thirdNoticeLabel)
        addSubviews(titleStackView, noticeStackView)
    }
    
    override func setLayout() {
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(12)
        }
        
        noticeIconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        noticeStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(12)
            $0.leading.equalTo(titleStackView).offset(7)
        }
    }
}
