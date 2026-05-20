//
//  SeatSelectionViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import SnapKit
import UIKit

final class SeatSelectionViewController: BaseUIViewController {
    // MARK: - Property
    
    private let scheduleId: Int
    private let selectedFare: SeatFare
    private let trainService: TrainServiceProtocol
    private var scheduleInfo: ScheduleInfo?
    private var selectedSeats: [Seat] = []
    private var paymentBottomView: PaymentBottomSheetView?
    private let priceFormatter = NumberFormatter.koreanDecimal()
    
    // MARK: - UI Components
    
    private let paymentBottomSheetHeight: CGFloat = 150
    private lazy var rootView = {
        let rootView = SeatSelectionView(model: SeatSelectionModel.placeholder)
        rootView.selectedSeatsDidChange = { [weak self] selectedSeats in
            self?.updatePaymentBottomSheet(selectedSeats: selectedSeats)
        }
        return rootView
    }()
    
    // MARK: - Initializer
    
    init(
        scheduleId: Int,
        selectedFare: SeatFare,
        trainService: TrainServiceProtocol = TrainService()
    ) {
        self.scheduleId = scheduleId
        self.selectedFare = selectedFare
        self.trainService = trainService
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
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
    
    private func updatePaymentBottomSheet(selectedSeats: [Seat]) {
        self.selectedSeats = selectedSeats
        
        if !self.selectedSeats.isEmpty {
            showPaymentBottomSheet(selectedSeatCount: self.selectedSeats.count)
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
                async let seatsResponse = fetchSeats(scheduleId: scheduleId)
                
                let schedules = try await schedulesResponse
                let seats = try await seatsResponse
                guard let scheduleInfo = schedules.first(where: { $0.scheduleId == self.scheduleId }) else {
                    return
                }
                self.scheduleInfo = scheduleInfo
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
