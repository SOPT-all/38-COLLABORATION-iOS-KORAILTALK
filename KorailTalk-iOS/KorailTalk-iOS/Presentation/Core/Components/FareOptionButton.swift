//
//  FareOptionButton.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/13/26.
//

import UIKit

import SnapKit
import Then

enum SeatType {
    case standard, special
    
    var radius: CGFloat {
        return 8
    }
    
    var title: String {
        switch self {
        case .standard: return "일반석"
        case .special: return "특별석"
        }
    }
    
    var fare: Int? {
        switch self {
        case .standard: return 34700
        case .special: return 61700
        }
    }
}

enum SeatStatus {
    case available
    case soldout
}

struct FareOption {
    let seatType: SeatType
    let status: SeatStatus
    let fare: Int?
}

final class FareOptionButton: UIButton {
    
    // MARK: - Properties
    
    private let fareOption: FareOption
    internal let optionLabel = UILabel()
    private let fareLabel = UILabel()
    private let stackView = UIStackView()
    
    override var isHighlighted: Bool {
        didSet {
            updateColor(isSelected: isSelected)
        }
    }
    
    // MARK: - Initializer
    
    init(fareOption: FareOption) {
        self.fareOption = fareOption
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
        self.layer.cornerRadius = fareOption.seatType.radius
        self.clipsToBounds = true
        layer.borderWidth = 1
        
        switch fareOption.status {
        case .available:
            updateColor(isSelected: false)
            
        case .soldout:
            self.backgroundColor = .neutral200
            self.layer.borderColor = UIColor.neutral300.cgColor
            optionLabel.textColor = .neutral300
            fareLabel.textColor = .neutral300
        }
    }
    
    private func setButtonLable() {
        optionLabel.do {
            $0.font = .pretendard(.body2)
            $0.textAlignment = .center
            $0.text = fareOption.seatType.title
            if fareOption.status == .soldout {
                $0.text = "매진"
            } else {
                $0.text = fareOption.seatType.title
            }
        }
        
        fareLabel.do {
            $0.font = .pretendard(.body4)
            $0.textAlignment = .center
            if fareOption.status == .available,
               let fare = fareOption.fare {
                $0.text = "\(fare)원"
            } else {
                $0.text = nil
            }
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 1
        }
    }
    
    private func setButtonLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
    }
    
    private func setUI() {
        addSubview(stackView)
        stackView.addArrangedSubviews(optionLabel, fareLabel)
    }
    
    private func updateColor(isSelected: Bool) {
        if isSelected {
            self.layer.borderColor = UIColor.primary400.cgColor
            self.backgroundColor = .primary400
            optionLabel.textColor = .white
            fareLabel.textColor = .neutral200
            if fareOption.status == .soldout {
                optionLabel.textColor = .white
            } else {
                optionLabel.textColor = .neutral100
            }
        } else {
            self.layer.borderColor = UIColor.secondary700.cgColor
            self.backgroundColor = .white
            fareLabel.textColor = .neutral700
            if fareOption.status != .soldout {
                optionLabel.textColor = .secondary700
            } else {
                optionLabel.textColor = .neutral300
            }
        }
    }
}
