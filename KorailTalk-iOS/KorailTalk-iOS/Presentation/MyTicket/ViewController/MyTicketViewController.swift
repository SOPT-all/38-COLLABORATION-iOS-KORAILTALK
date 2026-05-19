//
//  MyTicketViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit
import Then

final class MyTicketViewController: BaseUIViewController {
    
    // MARK: - UI Components
    
    private let myTicketCollectionView = MyTicketCollectionView()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        navigationBar.configure(title: "나의 티켓", showsRefreshButton: false)
        view.backgroundColor = .neutral100
    }
    
    override func setUI() {
        view.addSubview(myTicketCollectionView)
    }
    
    override func setLayout() {
        myTicketCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
    }
}
