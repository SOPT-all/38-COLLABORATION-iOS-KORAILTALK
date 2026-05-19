import UIKit

import SnapKit
import Then

enum GuideType {
    case vr
    case myTicket
}

final class GradientGuideView: BaseUIView {
    
    // MARK: - Property
    
    private let type: GuideType
    private var backgroundGradientLayer: CAGradientLayer?
    
    // MARK: - UI Components
    
    private let rootStackView = UIStackView()
    private let iconImageView = UIImageView()
    private let guideLabel = UILabel()
    
    // MARK: - Initializer
    
    init(type: GuideType = .vr, text: String? = nil) {
        self.type = type
        super.init(frame: .zero)
        
        if let text {
            self.guideLabel.text = text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            $0.isHidden = (type == .myTicket)
        }
        
        guideLabel.do {
            if $0.text == nil {
                $0.text = (type == .vr) ? "VR 기능으로 좌석을 미리 확인해보세요!" : "3일 뒤에 출발하는 열차가 있어요!"
            }
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
        
        if type == .vr {
            iconImageView.snp.makeConstraints {
                $0.width.equalTo(24)
                $0.height.equalTo(24)
            }
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
