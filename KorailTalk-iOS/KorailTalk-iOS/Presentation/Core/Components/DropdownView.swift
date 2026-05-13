//
//  DropdownView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/12/26.
//

import UIKit

import SnapKit
import Then

final class DropdownView: BaseUIView {
    
    private var isExpanded = false
    
    // MARK: - UI Components
    
    private let selectButton = UIButton()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let dropdownTableView = UITableView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        selectButton.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 26
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.text = "일반석"
            $0.textColor = .neutral700
            $0.font = .pretendard(.caption1)
        }
        
        arrowImageView.do {
            $0.image = UIImage(named: "ic_chevrondown")
            $0.tintColor = .gray
            $0.contentMode = .scaleAspectFit
        }
        
        dropdownTableView.do {
            $0.separatorStyle = .none
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
            
            $0.register(
                UITableViewCell.self,
                forCellReuseIdentifier: "cell"
            )
        }
    }
    
    override func setUI() {
        addSubviews(selectButton, dropdownTableView)
        selectButton.addSubviews(titleLabel, arrowImageView)
    }
    
    override func setLayout() {
        selectButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectButton)
            $0.leading.equalTo(selectButton).offset(12)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(selectButton)
            $0.trailing.equalTo(selectButton).inset(12)
            $0.width.equalTo(10)
            $0.height.equalTo(6)
        }
        
        dropdownTableView.snp.makeConstraints {
            $0.top.equalTo(selectButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
    }
    
    override func setAddTarget() {
        selectButton.addTarget(self, action: #selector(selectButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Public Method
    
    // MARK: - Action
    
    @objc
    private func selectButtonDidTap() {
        isExpanded.toggle()
        
        dropdownTableView.snp.updateConstraints {
            $0.height.equalTo(
                isExpanded ? 300 : 0
            )
        }
        
        
        UIView.animate(withDuration: 0.25) {
            self.arrowImageView.transform =
            self.isExpanded
            ? CGAffineTransform(rotationAngle: .pi)
            : .identity
            
            self.layoutIfNeeded()
        }
    }
    
}
