//
//  PopupView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/19/26.
//

import UIKit

import SnapKit
import Then

class PopupView: BaseUIView {
    
    // MARK: - Properties
    
    var onTapConfirmButton: (() -> Void)?
    var onTapTicketButton: (() -> Void)?
    
    // MARK: - UI Components
    
    private let paymentView = UIView()
    private let paymentImageView = UIImageView()
    private let paymentStackView = UIStackView()
    private let succeessIconView = UIImageView()
    private let paymentTitleLabel = UILabel()
    
    private let buttonStackView = UIStackView()
    private let ticketButton = KorailButton(type: .ticket)
    private let confirmButton = KorailButton(type: .confirm)
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        paymentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
        }
        
        paymentImageView.do {
            $0.image = .cardIcon
        }
        
        paymentStackView.do {
            $0.axis = .horizontal
            $0.spacing = 6
        }
        
        succeessIconView.do {
            $0.image = .icSuccessCheck
        }
        
        paymentTitleLabel.do {
            $0.text = "결제가 완료되었습니다!"
            $0.font = .pretendard(.body3)
            $0.textColor = .black
        }
        
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 7
        }
    }
    
    override func setUI() {
        addSubview(paymentView)
        
        paymentView.addSubviews(paymentImageView, paymentStackView, buttonStackView)
        paymentStackView.addArrangedSubviews(succeessIconView, paymentTitleLabel)
        buttonStackView.addArrangedSubviews(ticketButton, confirmButton)
    }
    
    override func setLayout() {
        paymentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(273)
        }
        
        paymentImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.centerX.equalToSuperview()
        }
        
        paymentStackView.snp.makeConstraints {
            $0.top.equalTo(paymentImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        succeessIconView.snp.makeConstraints {
            $0.size.equalTo(17)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        ticketButton.snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(47)
        }
    }
    
    override func setAddTarget() {
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        ticketButton.addTarget(self, action: #selector(didTapTicketButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapConfirmButton() {
        onTapConfirmButton?()
    }

    @objc
    private func didTapTicketButton() {
        onTapTicketButton?()
    }
}
