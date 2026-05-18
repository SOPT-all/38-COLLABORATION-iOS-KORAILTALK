//
//  GuideButton.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/18/26.
//

import UIKit

import SnapKit
import Then

final class GuideButton: UIButton {
    
    private let arrowImageView = UIImageView()
    private let titleLabelView = UILabel()
    private let underlineView = UIView()
    
    init(title: String) {
        super.init(frame: .zero)
        
        setStyle(title: title)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setStyle(title: String) {
        arrowImageView.do {
            $0.image = .icCaretBeside
            $0.tintColor = .primary500
        }
        
        titleLabelView.do {
            $0.text = title
            $0.font = .pretendard(.header2)
            $0.textColor = .primary500
        }
        
        underlineView.do {
            $0.backgroundColor = .primary500
        }
    }
    
    private func setUI() {
        addSubviews(
            arrowImageView,
            titleLabelView,
            underlineView
        )
    }
    
    private func setLayout() {
        arrowImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(titleLabelView)
            $0.size.equalTo(20)
        }
        
        titleLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(titleLabelView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}
