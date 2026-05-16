//
//  SeatSelectionViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class SeatSelectionViewController: BaseUIViewController {

    // MARK: - Property

    private let paymentBottomSheetHeight: CGFloat = 150
    private let seatSelectionModel = SeatSelectionModel.mock
    private var paymentBottomView: PaymentBottomSheetView?
    private var currentSelectedSeatCount = 0
    private let priceFormatter = NumberFormatter().then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.numberStyle = .decimal
    }

    // MARK: - UI Components

    private lazy var rootView = SeatSelectionView(model: seatSelectionModel)

    // MARK: - Custom Methods

    override func setUI() {
        view.addSubview(rootView)
        navigationBar.configure(title: "좌석 조회", showsRefreshButton: true)
    }

    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    override func setAddTarget() {
        rootView.selectedSeatCountDidChange = { [weak self] selectedSeatCount in
            self?.updatePaymentBottomSheet(selectedSeatCount: selectedSeatCount)
        }
    }

    // MARK: - Action

    private func updatePaymentBottomSheet(selectedSeatCount: Int) {
        currentSelectedSeatCount = selectedSeatCount

        if selectedSeatCount > 0 {
            showPaymentBottomSheet()
        } else {
            hidePaymentBottomSheet()
        }
    }

    private func showPaymentBottomSheet() {
        rootView.updateSeatCollectionBottomInset(paymentBottomSheetHeight)

        if let paymentBottomView {
            paymentBottomView.dataBind(
                price: formattedPrice(for: currentSelectedSeatCount),
                amount: "\(currentSelectedSeatCount)"
            )
            return
        }

        let paymentBottomSheetView = PaymentBottomSheetView()
        paymentBottomSheetView.dataBind(
            price: formattedPrice(for: currentSelectedSeatCount),
            amount: "\(currentSelectedSeatCount)"
        )

        view.addSubview(paymentBottomSheetView)

        paymentBottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(paymentBottomSheetHeight)
        }

        paymentBottomSheetView.show()
        paymentBottomView = paymentBottomSheetView
    }

    private func hidePaymentBottomSheet() {
        guard let paymentBottomSheetView = paymentBottomView else { return }
        rootView.updateSeatCollectionBottomInset(0)

        paymentBottomSheetView.hide { [weak self] in
            paymentBottomSheetView.removeFromSuperview()
            self?.paymentBottomView = nil
        }
    }

    private func totalPrice(for selectedSeatCount: Int) -> Int {
        let seatPrice = seatSelectionModel.selectedSeatFare?.price ?? 0
        return seatPrice * selectedSeatCount
    }

    private func formattedPrice(for selectedSeatCount: Int) -> String {
        let totalPrice = totalPrice(for: selectedSeatCount)
        return priceFormatter.string(from: NSNumber(value: totalPrice)) ?? "\(totalPrice)"
    }
}
