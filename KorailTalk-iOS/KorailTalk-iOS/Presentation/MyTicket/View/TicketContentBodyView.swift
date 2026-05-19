//
//  TicketContentBodyView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import UIKit

import SnapKit
import Then

final class TicketContentBodyView: BaseUIView {
    
    // MARK: - UI Components
    
    private let contentStackView = UIStackView()
    
    private let platformImageStackView = UIStackView()
    private let platformImageView = UIImageView()
    private let platformMinuteLabel = UILabel()
    
    private let trainValueLabel = UILabel()
    private let seatValueLabel = UILabel()
    
    private let qrImageContainer = UIView()
    private let qrImageView = UIImageView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        contentStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
        
        platformImageStackView.do {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .center
        }
        
        platformImageView.do {
            $0.image = .icRefreshFlatform
            $0.tintColor = .primary500
            $0.contentMode = .scaleAspectFit
        }
        
        platformMinuteLabel.do {
            $0.font = .pretendard(.caption3)
            $0.textColor = .neutral500
            $0.text = "15분 전 표시"
            $0.textAlignment = .center
        }
        
        trainValueLabel.do {
            $0.textColor = .neutral900
            $0.font = .pretendard(.header3)
            $0.text = "4호차"
            $0.textAlignment = .center
        }
        
        seatValueLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .neutral900
            $0.font = .pretendard(.header3)
            $0.text = "11a"
            $0.textAlignment = .center
        }
        
        qrImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = .icQr
        }
    }
    
    override func setUI() {
        addSubview(contentStackView)
        
        platformImageStackView.addArrangedSubviews(platformImageView, platformMinuteLabel)
        qrImageContainer.addSubview(qrImageView)
        
        contentStackView.addArrangedSubviews(platformImageStackView, trainValueLabel, seatValueLabel, qrImageContainer)
    }
    
    override func setLayout() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        platformImageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        qrImageView.snp.makeConstraints {
            $0.size.equalTo(46)
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    
    func bindData(carNumber: Int, seats: [String]) {
        trainValueLabel.text = "\(carNumber)호차"
        seatValueLabel.text = seats.joined(separator: "\n")
    }
}
