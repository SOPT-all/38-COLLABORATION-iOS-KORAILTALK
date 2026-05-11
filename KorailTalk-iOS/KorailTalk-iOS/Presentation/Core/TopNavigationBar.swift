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
    
    // MARK: - Properties
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let rightStackView = UIStackView()
    private let refreshButton = UIButton()
    private let menuButton = UIButton()
    
    // MARK: - Public Methods
    
    override func setStyle() {
        backgroundColor = .primary600
        
        backButton.do {
            let image = UIImage(named: "ic_back")
            $0.setImage(image, for: .normal)
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
            let image = UIImage(named: "ic_refresh")
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
        }
        
        menuButton.do {
            let image = UIImage(named: "ic_menu")
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
        }
    }
    
    override func setUI() {
        
        addSubviews(backButton, titleLabel, rightStackView)
        
        rightStackView.addArrangedSubviews(
            refreshButton,
            menuButton
        )
        
        setAction()
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
}

// MARK: - Custom Methods

extension TopNavigationBar {
    private func setAction() {
        backButton.addTarget(
            self,
            action: #selector(backButtonDidTap),
            for: .touchUpInside
        )
    }
    
    func configure(
        title: String,
        showsRefreshButton: Bool = false
    ) {
        titleLabel.text = title
        refreshButton.isHidden = !showsRefreshButton
    }
    
    @objc
    private func backButtonDidTap() {
        if let navigationController = parentViewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            parentViewController?.dismiss(animated: true)
        }
    }
}
