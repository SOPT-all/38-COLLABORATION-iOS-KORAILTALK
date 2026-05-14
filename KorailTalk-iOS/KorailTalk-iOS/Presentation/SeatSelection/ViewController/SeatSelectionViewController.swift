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
    
    private var paymentBottomView: PaymentBottomSheetView?
    
    // MARK: - Action
    
    @objc
    private func showPaymentBottomSheet() {
        guard paymentBottomView == nil else { return }
        
        let paymentBottomSheetView = PaymentBottomSheetView()
        
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
