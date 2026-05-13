//
//  FareOptionButton.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/13/26.
//

import UIKit

import SnapKit
import Then

enum FareOptionButtonType {
    case standard, special, soldout
    
    var radius: CGFloat {
        return 8
    }
    
    var option: String? {
        switch self {
        case .standard: return "일반석"
        case .special: return "특별석"
        case .soldout: return "매진"
        }
    }
    
    var fare: Int?{
        switch self{
        case .standard: return 34700
        case .special: return 61700
        case .soldout: return nil
        }
    }
}

final class FareOptionButton: UIButton {
    
    // MARK: - Properties
    
    private let fareOptionButtonType: FareOptionButtonType
    internal let optionLabel = UILabel()
    private let fareLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - Initializer
    
    init(type: FareOptionButtonType, title: String? = nil) {
        self.fareOptionButtonType = type
        super.init(frame: .zero)
        setUI()
        setButtonStyle()
        setButtonLable()
        setButtonLayout()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 52)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonStyle() {
        self.layer.cornerRadius = fareOptionButtonType.radius
        self.clipsToBounds = true
        
        switch fareOptionButtonType {
        case .standard:
            self.layer.borderWidth = 1
            self.backgroundColor = .white
            updateColor(isPressed: true)
        case .special:
            self.layer.borderWidth = 1
            updateColor(isPressed: true)
        case .soldout:
            self.backgroundColor = .neutral200
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.neutral300.cgColor
        }
    }
    
    private func setButtonLable() {
        optionLabel.do{
            $0.font = .pretendard(.body2)
            $0.textColor = .secondary700
            $0.textAlignment = .center
            $0.text = fareOptionButtonType.option
            if fareOptionButtonType == .soldout {
                $0.textColor = .neutral300
            } else {
                $0.textColor = .secondary700
            }
        }
        
        fareLabel.do{
            $0.font = .pretendard(.body4)
            $0.textColor = .neutral700
            $0.textAlignment = .center
            if let fare = fareOptionButtonType.fare {
                $0.text = "\(fare)원"
            } else {
                $0.text = nil
            }
        }
        
        stackView.do{
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 1
        }
    }
    
    private func setButtonLayout(){
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    private func setUI(){
        addSubview(stackView)
        stackView.addArrangedSubviews(optionLabel,fareLabel)
    }
    
    private func updateColor(isPressed: Bool) {
        if isPressed {
            self.layer.borderColor = UIColor.primary400.cgColor
            self.backgroundColor = .primary400
        } else {
            self.layer.borderColor = UIColor.secondary700.cgColor
        }
    }
}
