import UIKit

import SnapKit
import Then

final class SeatCollectionViewCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "SeatCollectionViewCell"

    // MARK: - UI Components

    private let seatImageView = UIImageView()
    private let seatNumberLabel = UILabel()
    private let outletBadgeImageView = UIImageView()

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

        seatImageView.do {
            $0.contentMode = .scaleAspectFit
        }

        seatNumberLabel.do {
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral900
            $0.textAlignment = .center
        }

        outletBadgeImageView.do {
            $0.image = .icPower
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setUI() {
        contentView.addSubviews(seatImageView, seatNumberLabel, outletBadgeImageView)
    }

    private func setLayout() {
        seatImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        seatNumberLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        outletBadgeImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(14)
        }
    }

    func configure(with seat: Seat) {
        seatNumberLabel.text = "\(seat.number)"
        outletBadgeImageView.isHidden = !seat.hasOutlet

        switch seat.state {
        case .available:
            seatImageView.image = .icSeatForward
            seatNumberLabel.textColor = .neutral900
        case .selected:
            seatImageView.image = .icSeatForwardSelected
            seatNumberLabel.textColor = .surfaceDefault
        case .reserved:
            seatImageView.image = .icSeatForwardDisabled
            seatNumberLabel.textColor = .neutral300
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        seatNumberLabel.text = nil
        outletBadgeImageView.isHidden = true
    }
}
