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
    private let trainService: TrainServiceProtocol
    private var paymentBottomView: PaymentBottomSheetView?
    private let priceFormatter = NumberFormatter.koreanDecimal()

    // MARK: - UI Components

    private let paymentBottomSheetHeight: CGFloat = 150
    private lazy var rootView = {
        let rootView = SeatSelectionView(model: SeatSelectionModel.placeholder)
        rootView.selectedSeatCountDidChange = { [weak self] selectedSeatCount in
            self?.updatePaymentBottomSheet(selectedSeatCount: selectedSeatCount)
        }
        return rootView
    }()

    // MARK: - Initializer

    init(
        scheduleId: Int = 1,
        selectedFare: SeatFare = SeatSelectionModel.placeholder.fare.general,
        trainService: TrainServiceProtocol = TrainService()
    ) {
        self.scheduleId = scheduleId
        self.selectedFare = selectedFare
        self.trainService = trainService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSeatSelectionModel()
    }

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

    // MARK: - Action

    private func updatePaymentBottomSheet(selectedSeatCount: Int) {
        if selectedSeatCount > 0 {
            showPaymentBottomSheet(selectedSeatCount: selectedSeatCount)
        } else {
            hidePaymentBottomSheet()
        }
    }

    private func showPaymentBottomSheet(selectedSeatCount: Int) {
        rootView.updateSeatCollectionBottomInset(paymentBottomSheetHeight)

        if let paymentBottomView {
            paymentBottomView.dataBind(
                price: formattedPrice(for: selectedSeatCount),
                amount: "\(selectedSeatCount)"
            )
            return
        }

        let paymentBottomSheetView = PaymentBottomSheetView()
        paymentBottomSheetView.dataBind(
            price: formattedPrice(for: selectedSeatCount),
            amount: "\(selectedSeatCount)"
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

    private func formattedPrice(for selectedSeatCount: Int) -> String {
        let totalPrice = selectedFare.price * selectedSeatCount
        return priceFormatter.string(from: totalPrice) ?? "\(totalPrice)원"
    }
}

private extension SeatSelectionViewController {

    func fetchSeatSelectionModel() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                async let schedulesResponse = fetchSchedules()
                async let seatsResponse = fetchSeats(scheduleId: self.scheduleId)

                let schedules = try await schedulesResponse
                let seats = try await seatsResponse
                guard let scheduleInfo = schedules.first(where: { $0.scheduleId == self.scheduleId }) else {
                    return
                }
                let seatSelectionModel = SeatSelectionModel.makeModel(
                    train: scheduleInfo.trainInfo,
                    fare: scheduleInfo.trainFare,
                    selectedFare: selectedFare,
                    seats: seats
                )
                rootView.configure(model: seatSelectionModel)
            } catch {
                return
            }
        }
    }

    func fetchSchedules() async throws -> [ScheduleInfo] {
        try await withCheckedThrowingContinuation { continuation in
            trainService.fetchSchedules { result in
                continuation.resume(with: result)
            }
        }
    }

    func fetchSeats(scheduleId: Int) async throws -> [Seat] {
        try await withCheckedThrowingContinuation { continuation in
            trainService.fetchSeats(scheduleId: scheduleId) { result in
                continuation.resume(with: result)
            }
        }
    }

}
