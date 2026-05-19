//
//  PaymentSuccessModalView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class PaymentSuccessModalView: BaseUIView {
    
    // MARK: - UI Components
    
    private let dimmedView = UIView()
    let popupView = PopupView()
    
    // MARK: - Custom Methods

    override func setStyle() {
        backgroundColor = .clear
        
        dimmedView.do {
            $0.backgroundColor = UIColor.dimmedBlack.withAlphaComponent(0.6)
        }
    }

    override func setUI() {
        addSubviews(dimmedView, popupView)
    }

    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        popupView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(273)
        }
    }
}
