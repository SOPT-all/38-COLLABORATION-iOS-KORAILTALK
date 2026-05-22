import UIKit

import SnapKit
import Then

final class AisleCollectionViewCell: BaseUICollectionViewCell {

    // MARK: - UI Components

    private let arrowImageView = UIImageView()

    // MARK: - Custom Methods

    override func setStyle() {
        contentView.backgroundColor = .clear

        arrowImageView.do {
            $0.image = .icCaretUpDisabled.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .neutral300
        }
    }

    override func setUI() {
        contentView.addSubview(arrowImageView)
    }

    override func setLayout() {
        arrowImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(44)
        }
    }

    func configure(showsArrow: Bool) {
        arrowImageView.isHidden = !showsArrow
        arrowImageView.alpha = showsArrow ? 1 : 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        arrowImageView.isHidden = true
        arrowImageView.alpha = 0
    }
}
