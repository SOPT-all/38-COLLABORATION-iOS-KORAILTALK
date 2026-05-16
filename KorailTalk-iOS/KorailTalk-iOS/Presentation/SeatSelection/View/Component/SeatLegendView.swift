import UIKit

import SnapKit
import Then

final class SeatLegendView: BaseUIView {

    // MARK: - UI Components

    private let rootStackView = UIStackView()

    private let chargingStackView = UIStackView()
    private let chargingIconImageView = UIImageView()
    private let chargingLabel = UILabel()

    private let directionStackView = UIStackView()

    private let forwardStackView = UIStackView()
    private let forwardIconImageView = UIImageView()
    private let forwardLabel = UILabel()

    private let backwardStackView = UIStackView()
    private let backwardIconImageView = UIImageView()
    private let backwardLabel = UILabel()

    // MARK: - Custom Methods

    override func setStyle() {
        super.setStyle()

        for item in [rootStackView, chargingStackView, directionStackView, forwardStackView, backwardStackView] {
            item.do {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.spacing = 4
            }
        }
        rootStackView.distribution = .equalSpacing
        directionStackView.spacing = 10

        chargingIconImageView.do {
            $0.image = .icPower
            $0.contentMode = .scaleAspectFit
        }

        forwardIconImageView.do {
            $0.image = .icSeatForwardSmall
            $0.contentMode = .scaleAspectFit
        }

        backwardIconImageView.do {
            $0.image = .icSeatBackwardSmall
            $0.contentMode = .scaleAspectFit
        }

        chargingLabel.do {
            $0.text = "충전 가능"
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral900
        }

        forwardLabel.do {
            $0.text = "순방향"
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral900
        }

        backwardLabel.do {
            $0.text = "역방향"
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral900
        }
    }

    override func setUI() {
        addSubview(rootStackView)

        forwardStackView.addArrangedSubviews(forwardIconImageView, forwardLabel)
        backwardStackView.addArrangedSubviews(backwardIconImageView, backwardLabel)
        directionStackView.addArrangedSubviews(forwardStackView, backwardStackView)
        chargingStackView.addArrangedSubviews(chargingIconImageView, chargingLabel)
        rootStackView.addArrangedSubviews(chargingStackView, directionStackView)
    }

    override func setLayout() {
        rootStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        chargingIconImageView.snp.makeConstraints {
            $0.size.equalTo(14)
        }

        forwardIconImageView.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(13)
        }

        backwardIconImageView.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(13)
        }
    }
}
