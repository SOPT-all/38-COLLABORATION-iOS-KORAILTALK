import UIKit

import SnapKit
import Then

final class SeatSelectionHeaderView: BaseUIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        super.setStyle()
        
        titleLabel.do {
            $0.text = "무궁화호 1284 (일반석)"
            $0.font = .pretendard(.body3)
            $0.textColor = .surfaceDisabled
            $0.textAlignment = .center
        }
    }
    
    override func setUI() {
        addSubview(titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
