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
    
    // MARK: - UI Components
    
    private let rootView = TicketInformationView()
    private let primaryButton = KorailButton(type: .primary)
    
    // MARK: - Custom Methods
    
    override func setUI() {
        view.addSubviews(rootView, primaryButton)
        navigationBar.configure(title: "승차권 정보 확인")
        
        rootView.onTapBaggageGuideButton = { [weak self] in
            let vc = LuggagePolicyViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
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
}
