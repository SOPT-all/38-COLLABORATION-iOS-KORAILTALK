//
//  MyTicketCollectionHeaderView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketCollectionHeaderView: BaseUICollectionReusableView {
    
    // MARK: - UI Component
    
    private let gradientView = GradientGuideView(type: .myTicket)
    
    // MARK: - Custom Methods
    
    override func setUI() {
        addSubview(gradientView)
    }
    
    override func setLayout() {
        gradientView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview()
        }
    }
}
