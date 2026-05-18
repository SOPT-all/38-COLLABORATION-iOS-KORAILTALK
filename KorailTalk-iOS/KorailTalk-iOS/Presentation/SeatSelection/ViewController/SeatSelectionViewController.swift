//
//  SeatSelectionViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit

final class SeatSelectionViewController: BaseUIViewController {

    // MARK: - Property
    private let scheduleId: Int
    private let selectedFare: SeatFare
    private var seatSelectionModel = SeatSelectionModel.mock
    private var paymentBottomView: PaymentBottomSheetView?
    private var currentSelectedSeatCount = 0
    private let priceFormatter = NumberFormatter.koreanDecimal()

    // MARK: - UI Components

    private let paymentBottomSheetHeight: CGFloat = 150
    private lazy var rootView = makeRootView(model: seatSelectionModel)

    // MARK: - Initializer

    init(
        scheduleId: Int = 1,
        selectedFare: SeatFare = SeatSelectionModel.mock.fare.general
    ) {
        self.scheduleId = scheduleId
        self.selectedFare = selectedFare
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Methods

    override func setUI() {
        view.addSubview(rootView)
        navigationBar.configure(title: "좌석 조회", showsRefreshButton: true)
        fetchSchedule()
    }

    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
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
        return priceFormatter.string(from: totalPrice) ?? "\(totalPrice)원"
    }
}

private extension SeatSelectionViewController {

    func fetchSchedule() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let schedules = try await fetchSchedules()
                guard let scheduleInfo = schedules.first(where: { $0.scheduleId == self.scheduleId }) else {
                    return
                }
                let seats = try await fetchSeats(scheduleId: scheduleInfo.scheduleId)
                updateRootView(
                    with: SeatSelectionModel.makeModel(
                        train: scheduleInfo.trainInfo,
                        fare: scheduleInfo.trainFare,
                        selectedFare: selectedFare,
                        seats: seats
                    )
                )
            } catch {
                return
            }
        }
    }

    func fetchSchedules() async throws -> [ScheduleInfo] {
        try await withCheckedThrowingContinuation { continuation in
            TrainService().fetchSchedules { result in
                continuation.resume(with: result)
            }
        }
    }

    func fetchSeats(scheduleId: Int) async throws -> [Seat] {
        try await withCheckedThrowingContinuation { continuation in
            TrainService().fetchSeats(scheduleId: scheduleId) { result in
                continuation.resume(with: result)
            }
        }
    }

    func updateRootView(with seatSelectionModel: SeatSelectionModel) {
        self.seatSelectionModel = seatSelectionModel

        rootView.removeFromSuperview()

        rootView = makeRootView(model: seatSelectionModel)
        view.addSubview(rootView)
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    func makeRootView(model: SeatSelectionModel) -> SeatSelectionView {
        let rootView = SeatSelectionView(model: model)
        rootView.selectedSeatCountDidChange = { [weak self] selectedSeatCount in
            self?.updatePaymentBottomSheet(selectedSeatCount: selectedSeatCount)
        }

        return rootView
    }
}
