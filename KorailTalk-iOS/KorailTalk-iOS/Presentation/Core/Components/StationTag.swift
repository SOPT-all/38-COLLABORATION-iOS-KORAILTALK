//
//  StationTag.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/12/26.
//

import UIKit

import SnapKit
import Then

enum StationTagType {
    case small, large
    
    var padding: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        case .large:
            return UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .small:
            return .neutral200
        case .large:
            return .primary100
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small:
            return 5
        case .large:
            return 6
        }
    }
}

final class StationTag: BaseUIView {
    
    // MARK: - Property
    
    private let type: StationTagType
    
    // MARK: - UI Component
    
    private let titleLabel = UILabel()
    
    // MARK: - Initializer
    
    init(type: StationTagType, title: String? = nil) {
        self.type = type
        super.init(frame: .zero)
        
        setTagTitle(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        titleLabel.do {
            $0.textColor = .secondary700
            $0.textAlignment = .center
            $0.font = .pretendard(.body3)
        }
    }
    
    override func setUI() {
        addSubview(titleLabel)
        
        self.backgroundColor = type.backgroundColor
        self.layer.cornerRadius = type.cornerRadius
        self.clipsToBounds = true
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(type.padding)
        }
    }
    
    // MARK: - Public Method
    
    func setTagTitle(_ title: String?) {
        titleLabel.text = title
    }
}
