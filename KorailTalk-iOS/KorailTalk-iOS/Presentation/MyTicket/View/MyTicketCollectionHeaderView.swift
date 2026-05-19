//
//  MyTicketCollectionHeaderView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketCollectionHeaderView: UICollectionReusableView {
    
    // MARK: - Propety
    
    static let identifier = "MyTicketCollectionHeaderView"
    
    // MARK: - UI Component
    
    private let gradientView = GradientGuideView(type: .myTicket)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    private func setUI() {
        addSubview(gradientView)
    }
    
    private func setLayout() {
        gradientView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview()
        }
    }
}
