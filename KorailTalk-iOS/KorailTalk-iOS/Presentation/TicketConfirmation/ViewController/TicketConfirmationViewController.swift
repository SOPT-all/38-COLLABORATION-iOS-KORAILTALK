//
//  TicketConfirmationViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class TicketConfirmationViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    private let trainService: TrainServiceProtocol
    private let ticketInfoModel: TicketInformationModel
    private let scheduleId: Int
    private let selectedSeats: [Seat]
    private let userId: Int = 1
    
    // MARK: - Initializer
    
    init(
        scheduleId: Int,
        selectedSeats: [Seat],
        ticketInfoModel: TicketInformationModel,
        trainService: TrainServiceProtocol = TrainService()
    ) {
        self.scheduleId = scheduleId
        self.selectedSeats = selectedSeats
        self.ticketInfoModel = ticketInfoModel
        self.trainService = trainService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.configure(with: ticketInfoModel)
    }
    
    // MARK: - UI Components
    
    private let rootView = TicketInformationView()
    private let primaryButton = KorailButton(type: .primary)
    private let modalView = PaymentSuccessModalView()
    
    // MARK: - Custom Methods
    
    override func setUI() {
        view.addSubviews(rootView, primaryButton)
        navigationBar.configure(title: "승차권 정보 확인")
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        primaryButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedW)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.height.equalTo(53.adjustedW)
        }
    }
    
    override func setAddTarget() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        
        rootView.onTapBaggageGuideButton = { [weak self] in
            let viewController = LuggagePolicyViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        modalView.popupView.onTapConfirmButton = { [weak self] in
            self?.modalView.removeFromSuperview()
        }
        
        modalView.popupView.onTapTicketButton = { [weak self] in
            self?.modalView.removeFromSuperview()
            let viewController = MyTicketViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Action
    
    @objc
    private func didTapPrimaryButton() {
        requestSeatReservation()
    }
    
    // MARK: - Private Method
    
    private func showPaymentSuccessPopup() {
        view.addSubview(modalView)
        
        modalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        
        modalView.alpha = 0
        modalView.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.modalView.alpha = 1
            self.modalView.popupView.transform = .identity
        }
    }
}

// MARK: - API Calls

private extension TicketConfirmationViewController {
    func requestSeatReservation() {
        primaryButton.isEnabled = false
        
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let seatNumbers = selectedSeats.map { $0.number }
                
                try await reserveSeats(
                    scheduleId: scheduleId,
                    userId: userId,
                    seatNumbers: seatNumbers
                )
                
                print("🎉 좌석 예약 성공")
                
                primaryButton.isEnabled = true
                showPaymentSuccessPopup()
                
            } catch {
                primaryButton.isEnabled = true
                
                if let apiError = error as? APIErrorResponse {
                    print("🚨 error code: \(apiError.errorCode), mesasage: \(apiError.message)")
                    
                } else {
                    print("🚨 general error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func reserveSeats(scheduleId: Int, userId: Int, seatNumbers: [Int]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            trainService.reserveSeats(
                scheduleId: scheduleId,
                userId: userId,
                seatNumbers: seatNumbers
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
}
