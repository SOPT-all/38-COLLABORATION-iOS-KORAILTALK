import UIKit

import SnapKit
import Then

final class VRGuideView: BaseUIView {
    
    // MARK: - Property
    
    private var backgroundGradientLayer: CAGradientLayer?
    
    // MARK: - UI Components
    
    private let rootStackView = UIStackView()
    private let iconImageView = UIImageView()
    private let guideLabel = UILabel()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 10
        setBorder(borderColor: .primary100)
        
        rootStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 0
        }
        
        iconImageView.do {
            $0.image = .icVr.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .primary500
        }
        
        guideLabel.do {
            $0.text = "VR 기능으로 좌석을 미리 확인해보세요!"
            $0.font = .pretendard(.caption1)
            $0.textColor = .primary500
        }
    }
    
    override func setUI() {
        addSubview(rootStackView)
        rootStackView.addArrangedSubviews(iconImageView, guideLabel)
    }
    
    override func setLayout() {
        rootStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    // MARK: - Life Cycles

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if backgroundGradientLayer == nil {
            let gradientLayer = CAGradientLayer.infoBackground(in: bounds)
            layer.insertSublayer(gradientLayer, at: 0)
            backgroundGradientLayer = gradientLayer
        }
        
        backgroundGradientLayer?.frame = bounds
        backgroundGradientLayer?.cornerRadius = layer.cornerRadius
    }
}
