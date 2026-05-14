//
//  LuggagePolicyView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

import SnapKit
import Then

final class LuggagePolicyView: BaseUIView {
    
    // MARK: - UI Components
    
    private let luggageNoticeView = LuggageNoticeView()
    private let grayLineView = UIView()
    
    private let warningStackView = UIStackView()
    private let warningIconImageView = UIImageView()
    private let warningLabel = UILabel()
    
    private let itemStackView = UIStackView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        luggageNoticeView.do {
            $0.layer.cornerRadius = 10
        }
        
        grayLineView.do {
            $0.backgroundColor = .neutral100
        }
        
        warningStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        warningIconImageView.do {
            $0.image = .icProhibitedPlain
        }
        
        warningLabel.do {
            $0.text = "금지 물품을 휴대할시, 운송을 거절할 수 있어요!"
            $0.font = .pretendard(.header3)
            $0.textColor = .surfaceDisabled
        }
        
        itemStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
    }
    
    override func setUI() {
        warningStackView.addArrangedSubviews(warningIconImageView, warningLabel)
        addSubviews(luggageNoticeView, grayLineView, warningStackView, itemStackView)
        
        let items = ProhibitedItem.dummy()
        items.forEach { item in
            let itemView = ProhibitedItemView()
            itemView.configure(prohibitedItem: item)
            itemStackView.addArrangedSubview(itemView)
            
            itemView.snp.makeConstraints {
                $0.height.equalTo(85)
            }
        }
    }
    
    override func setLayout() {
        luggageNoticeView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(125)
        }
        
        grayLineView.snp.makeConstraints {
            $0.top.equalTo(luggageNoticeView.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        warningStackView.snp.makeConstraints {
            $0.top.equalTo(grayLineView.snp.bottom).offset(22)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        warningIconImageView.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        itemStackView.snp.makeConstraints {
            $0.top.equalTo(warningStackView.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(109)
        }
    }
}
