//
//  TicketConfirmationViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class TicketConfirmationViewController: BaseUIViewController {
    
    // MARK: - UI Components
    
    private let rootView = TicketInformationView()
    private let primaryButton = KorailButton(type: .primary)
    private let modalView = PaymentSuccessModalView()
    
    // MARK: - Custom Methods
    
    override func setUI() {
        view.addSubviews(rootView, primaryButton)
        navigationBar.configure(title: "승차권 정보 확인")
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        primaryButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedW)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.height.equalTo(53.adjustedW)
        }
    }
    
    override func setAddTarget() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        
        rootView.onTapBaggageGuideButton = { [weak self] in
            let viewController = LuggagePolicyViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        modalView.popupView.onTapConfirmButton = { [weak self] in
            self?.modalView.removeFromSuperview()
        }
        
        modalView.popupView.onTapTicketButton = { [weak self] in
            self?.modalView.removeFromSuperview()
            let viewController = MyTicketViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Action
    
    @objc
    private func didTapPrimaryButton() {
        showPaymentSuccessPopup()
    }
    
    // MARK: - Private Method
    
    private func showPaymentSuccessPopup() {
        view.addSubview(modalView)
        
        modalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        
        modalView.alpha = 0
        modalView.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.modalView.alpha = 1
            self.modalView.popupView.transform = .identity
        }
    }
}
