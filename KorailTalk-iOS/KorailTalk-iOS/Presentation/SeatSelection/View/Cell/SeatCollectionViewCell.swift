import UIKit

import SnapKit
import Then

final class SeatCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "SeatCollectionViewCell"
    
    // MARK: - UI Components
    
    private let seatNumberLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    private func setStyle() {
        contentView.backgroundColor = .clear
        
        seatNumberLabel.do {
            $0.text = "1"
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral900
            $0.textAlignment = .center
        }
    }
    
    private func setUI() {
        contentView.addSubview(seatNumberLabel)
    }
    
    private func setLayout() {
        seatNumberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
