//
//  LuggagePolicyViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

import SnapKit

final class LuggagePolicyViewController: BaseUIViewController {
    
    // MARK: - UI Components
    
    private let rootView = LuggagePolicyView()
    
    // MARK: - Custom Methods
    
    override func setUI() {
        view.addSubview(rootView)
        navigationBar.configure(title: "열차 내 물품 휴대 기준")
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
