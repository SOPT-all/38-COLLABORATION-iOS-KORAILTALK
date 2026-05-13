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
        
        let paymentbottomSheetView = PaymentBottomSheetView()
        
        view.addSubview(paymentbottomSheetView)
        
        paymentbottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        paymentbottomSheetView.show()
        paymentBottomView = paymentbottomSheetView
    }
    
    @objc
    private func hidePaymentBottomSheet() {
        guard let paymentbottomSheetView = paymentBottomView else { return }
        
        paymentbottomSheetView.hide { [weak self] in
            paymentbottomSheetView.removeFromSuperview()
            self?.paymentBottomView = nil
        }
    }
}
