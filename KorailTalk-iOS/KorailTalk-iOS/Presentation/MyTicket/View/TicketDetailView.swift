//
//  TicketDetailView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import UIKit

import SnapKit
import Then

final class TicketDetailView: BaseUIView {
    
    // MARK: - UI Components
    
    private let ticketNumberLabel = UILabel()
    private let grayLineView = UIView()
    
    private let titleHeaderView = TicketTitleHeaderView()
    private let contentBodyView = TicketContentBodyView()
    
    private let buttonStackView = UIStackView()
    private let returnButton = KorailButton(type: .outline, title: "반환하기")
    private let passButton = KorailButton(type: .outline, title: "승차권 전달하기")
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        self.backgroundColor = .white
        
        ticketNumberLabel.do {
            $0.text = "승차권번호 82106-0672-13233-31"
            $0.textColor = .neutral500
            $0.font = .pretendard(.caption2)
        }
        
        grayLineView.do {
            $0.backgroundColor = .neutral200
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.distribution = .fillEqually
        }
    }
    
    override func setUI() {
        addSubviews(ticketNumberLabel, grayLineView, titleHeaderView, contentBodyView, buttonStackView)
        buttonStackView.addArrangedSubviews(returnButton, passButton)
    }
    
    override func setLayout() {
        ticketNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        grayLineView.snp.makeConstraints {
            $0.top.equalTo(ticketNumberLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        titleHeaderView.snp.makeConstraints {
            $0.top.equalTo(grayLineView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contentBodyView.snp.makeConstraints {
            $0.top.equalTo(titleHeaderView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentBodyView.snp.bottom).offset(22)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(32)
        }
    }
    
    // MARK: - Public Method
    
    func configure(carNumber: Int, seats: [String]) {
        contentBodyView.bindData(carNumber: carNumber, seats: seats)
    }
}
