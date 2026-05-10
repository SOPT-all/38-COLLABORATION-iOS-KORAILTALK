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
    
    var backButtonAction: (() -> Void)?
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let rightStackView = UIStackView()
    private let refreshButton = UIButton()
    private let menuButton = UIButton()
    
    // MARK: - Public Methods
    
    override func setStyle() {
        backgroundColor = .systemBlue
        
        backButton.do {
            let image = UIImage(systemName: "")
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .white
        }
        
        rightStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .center
        }
        
        refreshButton.do {
            let image = UIImage(systemName: "")
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
        }
        
        menuButton.do {
            let image = UIImage(systemName: "")
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
        }
    }
    
    override func setUI() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(rightStackView)
        
        rightStackView.addArrangedSubview(refreshButton)
        rightStackView.addArrangedSubview(menuButton)
        
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

