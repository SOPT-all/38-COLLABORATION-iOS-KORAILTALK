//
//  TicketInformationView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/15/26.
//

import UIKit

import SnapKit
import Then

class TicketInformationView: BaseUIView {
    
    // MARK: - UI Components
    
    private let ticketInformationView = UIView()
    private let ticketStackView = UIStackView()
    private let trainInformationView = TrainInformationView()
    private let payPeriodStackView = UIStackView()
    private let payPeriodLabel = UILabel()
    private let payPeriodDateLabel = UILabel()
    private let payNoticeLabel = UILabel()
    private let grayLineView = UIView()
    private let reservationNoticeLabel = UILabel()
    private let ticketNumberLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let cancelButton = KorailButton(type: .outline, title: "예매 취소")
    private let cartButton = KorailButton(type: .outline, title: "장바구니")
    private let reservationNoticeView = ReservationNoticeView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .white
        
        ticketInformationView.do {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .neutral100
        }
        
        ticketStackView.do {
            $0.axis = .vertical
            $0.spacing = 23
            $0.alignment = .leading
            $0.distribution = .fill
        }
        
        payPeriodStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .firstBaseline
            $0.distribution = .fill
        }
        
        payPeriodStackView.setContentHuggingPriority(
            .required,
            for: .horizontal
        )
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.distribution = .fillEqually
        }
        
        payPeriodLabel.do {
            $0.text = "결제기한"
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral900
        }
        
        payPeriodDateLabel.do {
            $0.text = "2026. 4. 23. 금 23 : 56"
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral900
        }
        
        payNoticeLabel.do {
            $0.text = "기한 내 미결제시 승차권이 취소됩니다."
            $0.font = .pretendard(.caption2)
            $0.textColor = .semanticError
        }
        
        grayLineView.do {
            $0.backgroundColor = .neutral200
        }
        
        reservationNoticeLabel.do {
            $0.text = "미결제시 예약이 취소됩니다."
            $0.font = .pretendard(.body4)
            $0.textColor = .primary500
        }
        
        ticketNumberLabel.do {
            $0.text = "2매"
            $0.font = .pretendard(.body3)
            $0.textColor = .primary500
        }
    }
    
    override func setUI() {
        addSubviews(ticketInformationView, buttonStackView, grayLineView, reservationNoticeView)
        
        ticketInformationView.addSubviews(ticketStackView, payNoticeLabel, ticketNumberLabel, reservationNoticeLabel)
        
        payPeriodStackView.addArrangedSubviews(payPeriodLabel, payPeriodDateLabel)
        
        ticketStackView.addArrangedSubviews(trainInformationView, payPeriodStackView)
        
        buttonStackView.addArrangedSubviews(cancelButton, cartButton)
    }
    
    override func setLayout() {
        ticketInformationView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.horizontalEdges.equalToSuperview().inset(21)
            $0.height.equalTo(152)
        }
        
        ticketStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        payNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(ticketStackView.snp.bottom).offset(2)
            $0.leading.equalTo(ticketStackView)
        }
        
        ticketNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(ticketInformationView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(ticketInformationView)
            $0.height.equalTo(36)
        }
        
        grayLineView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(buttonStackView)
            $0.height.equalTo(1)
        }
        
        reservationNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(grayLineView.snp.bottom).offset(10)
            $0.leading.equalTo(grayLineView)
        }
        
        reservationNoticeView.snp.makeConstraints {
            $0.top.equalTo(reservationNoticeLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview()
        }
    }
}
