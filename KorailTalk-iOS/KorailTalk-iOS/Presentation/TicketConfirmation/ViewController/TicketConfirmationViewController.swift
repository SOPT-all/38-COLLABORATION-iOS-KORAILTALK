//
//  TicketConfirmationViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit

final class TicketConfirmationViewController: BaseUIViewController {
    
    // MARK: - UI
    
    private let navigationBar = TopNavigationBar()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUI()
        setLayout()
        setNavigationBar()
    }
    
    // MARK: - Public Methods

    
    override func setUI() {
        view.addSubview(navigationBar)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
    
    // MARK: - Custom Methods
    
    func setNavigationBar() {
        navigationBar.configure(
            title: "좌석 조회",
            showsRefreshButton: true
        )
    }
}
