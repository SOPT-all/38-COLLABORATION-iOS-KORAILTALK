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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonStyle() {
        self.layer.cornerRadius = fareOptionButtonType.radius
        self.clipsToBounds = true
        
        switch fareOptionButtonType {
        case .standard:
            self.backgroundColor = .white
            updateOutlineColor(isPressed: false)
        case .special:
            self.layer.borderWidth = 1
            updateOutlineColor(isPressed: false)
        case .soldout:
            self.backgroundColor = .neutral200
        }
    }
    
    private func setButtonLable() {
        optionLabel.do{
            $0.font = .pretendard(.body2)
            $0.textColor = .secondary700
            $0.textAlignment = .center
            $0.text = fareOptionButtonType.option
        }
        
        fareLabel.do{
            $0.font = .pretendard(.body4)
            $0.textColor = .neutral700
            $0.textAlignment = .center
            $0.text = "\(fareOptionButtonType.fare ?? 0)원"
        }
        
        stackView.do{
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 1
        }
    }
    
    private func setButtonLayout(){
        stackView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func setUI(){
        addSubview(stackView)
        stackView.addArrangedSubviews(optionLabel,fareLabel)
    }
    
    private func setButionFare(_ fare: Int? = nil){
        let buttonfare = fare ?? fareOptionButtonType.fare
    }
    
    private func updateOutlineColor(isPressed: Bool) {
        if isPressed {
            self.layer.borderColor = UIColor.primary400.cgColor
        } else {
            self.layer.borderColor = UIColor.secondary700.cgColor
        }
    }
}
