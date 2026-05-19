//
//  TicketTitleHeaderView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class TicketTitleHeaderView: BaseUIView {
    
    // MARK: - UI Components
    
    private let titleStackView = UIStackView()
    private let platformTitleLabel = UILabel()
    private let trainTitleLabel = UILabel()
    private let seatTitleLabel = UILabel()
    private let qrTitleLabel = UILabel()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        titleStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
        
        let configureTitleLabel: (UILabel, String) -> Void = { label, text in
            label.do {
                $0.text = text
                $0.textColor = .neutral700
                $0.font = .pretendard(.body3)
                $0.textAlignment = .center
            }
        }
        
        configureTitleLabel(platformTitleLabel, "타는 곳")
        configureTitleLabel(trainTitleLabel, "기차")
        configureTitleLabel(seatTitleLabel, "좌석")
        configureTitleLabel(qrTitleLabel, "QR코드")
    }
    
    override func setUI() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubviews(platformTitleLabel, trainTitleLabel, seatTitleLabel, qrTitleLabel)
    }
    
    override func setLayout() {
        titleStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
