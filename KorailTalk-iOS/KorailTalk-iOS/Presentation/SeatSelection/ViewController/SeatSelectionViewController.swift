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
    
    private let seatSelectionModel = SeatSelectionModel.mock
    private var paymentBottomView: PaymentBottomSheetView?
    
    // MARK: - UI Components
    
    private let rootView = SeatSelectionView()
    
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
    
    @objc
    private func showPaymentBottomSheet() {
        guard paymentBottomView == nil else { return }
        
        let paymentBottomSheetView = PaymentBottomSheetView()
        paymentBottomSheetView.dataBind(
            price: "\(seatSelectionModel.totalPrice)",
            amount: "\(seatSelectionModel.selectedSeatCount)"
        )
        
        view.addSubview(paymentBottomSheetView)
        
        paymentBottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        paymentBottomSheetView.show()
        paymentBottomView = paymentBottomSheetView
    }
    
    @objc
    private func hidePaymentBottomSheet() {
        guard let paymentBottomSheetView = paymentBottomView else { return }
        
        paymentBottomSheetView.hide { [weak self] in
            paymentBottomSheetView.removeFromSuperview()
            self?.paymentBottomView = nil
        }
    }
}
