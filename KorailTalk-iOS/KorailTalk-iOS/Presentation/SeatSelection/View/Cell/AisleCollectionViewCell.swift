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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Methods

    private func setStyle() {
        contentView.backgroundColor = .clear

        arrowImageView.do {
            $0.image = .icCaretUpDisabled.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .neutral300
        }
    }

    private func setUI() {
        contentView.addSubview(arrowImageView)
    }

    private func setLayout() {
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
