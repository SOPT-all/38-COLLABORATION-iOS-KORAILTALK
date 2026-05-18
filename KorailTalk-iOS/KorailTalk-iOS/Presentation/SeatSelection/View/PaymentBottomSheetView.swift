//
//  PaymentBottomSheetView.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/12/26.
//

import UIKit

import SnapKit
import Then

final class PaymentBottomSheetView: BaseUIView {

    // MARK: - Property

    private let sheetHeight: CGFloat = 150

    // MARK: - UI Components

    private let shadowView = UIView()
    private let contentView = UIView()

    private let totalStackView = UIStackView()
    private let totalPriceLabel = UILabel()
    private let totalAmountLabel = UILabel()

    private let seatTypeLabel = UILabel()
    private let priceLabel = UILabel()

    private lazy var paymentButton = KorailButton(type: .primary)

    // MARK: - Custom Methods

    override func setStyle() {
        backgroundColor = .clear

        shadowView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

            $0.layer.shadowColor = UIColor.neutral300.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: -1)
            $0.layer.shadowOpacity = 0.7
            $0.layer.shadowRadius = 5
            $0.layer.masksToBounds = false
        }

        contentView.do {
            $0.backgroundColor = .surfaceDefault
            $0.layer.cornerRadius = 10
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }

        totalStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }

        totalPriceLabel.do {
            $0.text = "총 금액"
            $0.font = .pretendard(.header4)
            $0.textColor = .neutral900
        }

        totalAmountLabel.do {
            $0.font = .pretendard(.header4)
            $0.textColor = .neutral900
        }

        seatTypeLabel.do {
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral500
        }

        priceLabel.do {
            $0.font = .pretendard(.header4)
            $0.textColor = .primary600
        }

        paymentButton.do {
            $0.setTitle("결제하기", for: .normal)
        }
    }

    override func setUI() {
        addSubviews(shadowView, contentView)

        totalStackView.addArrangedSubviews(totalPriceLabel, totalAmountLabel)
        contentView.addSubviews(totalStackView, seatTypeLabel, priceLabel, paymentButton)
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }

        shadowView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        totalStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(14.5)
        }

        seatTypeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(totalStackView.snp.bottom).offset(4)
        }

        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalTo(totalStackView)
        }

        paymentButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24.5)
            $0.horizontalEdges.equalToSuperview().inset(18.5)
            $0.height.equalTo(53)
        }
    }

    override func setAddTarget() {
        paymentButton.addTarget(self, action: #selector(paymentButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Public Methods

    func show() {
        contentView.transform = CGAffineTransform(translationX: 0, y: sheetHeight)
        shadowView.transform = CGAffineTransform(translationX: 0, y: sheetHeight)

        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = .identity
            self.shadowView.transform = .identity
        }
    }

    func hide(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: self.sheetHeight)
                self.shadowView.transform = CGAffineTransform(translationX: 0, y: self.sheetHeight)
            },
            completion: { _ in
                completion?()
            }
        )
    }

    func dataBind(price: String, amount: String) {
        seatTypeLabel.text = "어른 \(amount)"
        priceLabel.text = price
        totalAmountLabel.text = "(\(amount)장)"
    }

    // MARK: - Action

    @objc
    private func paymentButtonDidTap() {
        // TODO: - 승차권 정보 확인 View로 이동
    }
}
