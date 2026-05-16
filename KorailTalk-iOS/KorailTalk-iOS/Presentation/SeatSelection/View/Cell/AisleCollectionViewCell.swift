import UIKit

import SnapKit
import Then

final class AisleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "AisleCollectionViewCell"
    
    // MARK: - UI Components
    
    private let arrowImageView = UIImageView()
    
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
        
        arrowImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setUI() {
        contentView.addSubview(arrowImageView)
    }
    
    private func setLayout() {
        arrowImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(6)
            $0.height.equalTo(4)
        }
    }
}
