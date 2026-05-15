//
//  TrainSearchViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit

final class TrainSearchViewController: BaseUIViewController {
    // MARK: - UI Components
    
    private let rootView = TrainSearchView()
    
    // MARK: - Custom Methods
    
    override func setUI() {
        view.addSubview(rootView)
        navigationBar.configure(title: "승차권 조회")
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
