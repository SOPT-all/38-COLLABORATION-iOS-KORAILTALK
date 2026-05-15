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
    private let blueLineView = UIView()
    
    private let payStackView = UIStackView()
    private let payPeriodStackView = UIStackView()
    
    private let payPeriodLabel = UILabel()
    private let payNoticeLabel = UILabel()
    private let reservationNoticeLabel = UILabel()
    
    private let cancelButton = KorailButton(type: .outline, title: "예매 취소")
    private let cartButton = KorailButton(type: .outline, title: "장바구니")
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        ticketInformationView.do {
            $0.layer.cornerRadius = 15
        }
        
        blueLineView.do {
            $0.backgroundColor = .neutral100
        }
        
        
        
    }

}
