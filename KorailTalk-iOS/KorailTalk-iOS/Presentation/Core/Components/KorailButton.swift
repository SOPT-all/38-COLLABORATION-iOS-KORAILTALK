//
//  KorailButton.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/12/26.
//

import UIKit

import SnapKit
import Then

final class KorailButton: UIButton {
    
    // MARK: - Properties
    
    private let korailButtonType: KorailButtonType
    
    override var isHighlighted: Bool {
        didSet {
            if korailButtonType == .outline {
                updateOutlineColor(isPressed: isHighlighted)
            }
        }
    }
    
    // MARK: - Initializer
    
    init(type: KorailButtonType, title: String? = nil) {
        self.korailButtonType = type
        super.init(frame: .zero)
        
        setButtonStyle()
        setButtonTitle(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonStyle() {
        self.layer.cornerRadius = korailButtonType.radius
        self.clipsToBounds = true
        
        switch korailButtonType {
        case .primary:
            self.backgroundColor = .primary500
            self.titleLabel?.font = .pretendard(.header3)
            self.setTitleColor(.surfaceDefault, for: .normal)
        case .outline:
            self.layer.borderWidth = 1
            updateOutlineColor(isPressed: false)
            self.titleLabel?.font = .pretendard(.body4)
            self.setTitleColor(.black, for: .normal)
        case .ticket:
            self.backgroundColor = .primary500
            self.titleLabel?.font = .pretendard(.header3)
            self.setTitleColor(.white, for: .normal)
        case .confirm:
            self.backgroundColor = .primary100
            self.titleLabel?.font = .pretendard(.header3)
            self.setTitleColor(.secondary700, for: .normal)
        }
    }
    
    private func setButtonTitle(_ title: String?) {
        let buttonTitle = title ?? korailButtonType.title
        self.setTitle(buttonTitle, for: .normal)
    }
    
    private func updateOutlineColor(isPressed: Bool) {
        if isPressed {
            self.layer.borderColor = UIColor.primary500.cgColor
        } else {
            self.layer.borderColor = UIColor.neutral200.cgColor
        }
    }
}
