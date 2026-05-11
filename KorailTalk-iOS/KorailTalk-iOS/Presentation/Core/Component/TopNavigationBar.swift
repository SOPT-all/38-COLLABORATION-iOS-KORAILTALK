//
//  TopNavigationBar.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class TopNavigationBar : BaseUIView {
    
    // MARK: - Property
    
    var backButtonAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let rightStackView = UIStackView()
    private let refreshButton = UIButton()
    private let menuButton = UIButton()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .primary600
        
        backButton.do {
            $0.setImage(.icBack, for: .normal)
            $0.tintColor = .white
        }
        
        titleLabel.do {
            $0.font = .pretendard(.header2)
            $0.textColor = .white
        }
        
        rightStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .center
        }
        
        refreshButton.do {
            $0.setImage(.icRefresh, for: .normal)
            $0.tintColor = .white
        }
        
        menuButton.do {
            $0.setImage(.icMenu, for: .normal)
            $0.tintColor = .white
        }
    }
    
    override func setUI() {
        addSubviews(backButton, titleLabel, rightStackView)
        rightStackView.addArrangedSubviews(refreshButton, menuButton)
    }
    
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            $0.size.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton)
        }
        
        rightStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(7)
            $0.centerY.equalTo(backButton)
        }
        
        refreshButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        menuButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
    }
    
    override func setAddTarget() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Public Method

    func configure(title: String, showsRefreshButton: Bool = false) {
        titleLabel.text = title
        refreshButton.isHidden = !showsRefreshButton
    }
    
    // MARK: - Action
    
    @objc
    private func backButtonDidTap() {
        backButtonAction?()
    }
}


