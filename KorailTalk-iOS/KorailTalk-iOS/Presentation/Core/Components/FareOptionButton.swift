//
//  FareOptionButton.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/13/26.
//

import UIKit

import SnapKit
import Then

struct FareOption {
    let seatType: KorailSeatType
    let status: SeatStatus
    let fare: Int?
}

final class FareOptionButton: UIButton {
    
    // MARK: - Properties
    
    private var fareOption: FareOption
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
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonStyle() {
        switch fareOption.status {
        case .available:
            updateColor(isSelected: false)
            
        case .soldout:
            setSoldoutStyle()
        }
    }
    
    private func setSoldoutStyle() {
        self.backgroundColor = .neutral200
        self.layer.borderColor = UIColor.neutral300.cgColor
        optionLabel.textColor = .neutral300
        fareLabel.textColor = .neutral300
    }
    
    private func setStyle() {
        optionLabel.do {
            $0.font = .pretendard(.body2)
            $0.textAlignment = .center
            $0.text = (fareOption.status == .soldout) ? "매진" : fareOption.seatType.title
        }
        
        fareLabel.do {
            $0.font = .pretendard(.body4)
            $0.textAlignment = .center
            $0.text = (fareOption.status == .available) ? fareOption.fare.map { "\($0)원" } : nil
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 1
        }
        
        self.layer.cornerRadius = fareOption.seatType.radius
        self.clipsToBounds = true
        layer.borderWidth = 1
    }
    
    private func setUI() {
        addSubview(stackView)
        stackView.addArrangedSubviews(optionLabel, fareLabel)
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
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
    
    func updateConfig(fare: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedFare = formatter.string(from: NSNumber(value: fare)) {
            fareLabel.text = "\(formattedFare)원"
        }
    }
    
    func updateSoldOut() {
        fareOption = FareOption(
            seatType: fareOption.seatType,
            status: .soldout,
            fare: nil
        )

        optionLabel.text = "매진"
        fareLabel.text = nil
        isEnabled = false
        setSoldoutStyle()
    }
}
