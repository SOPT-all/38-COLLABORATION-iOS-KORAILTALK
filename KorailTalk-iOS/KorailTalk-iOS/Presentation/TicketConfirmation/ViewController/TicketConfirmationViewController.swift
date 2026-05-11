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
    
    // MARK: - Property
    
    private let navigationBar = TopNavigationBar()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.configure(title: "승차권 정보 조회", showsRefreshButton: true)
            $0.backButtonAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func setUI() {
        view.addSubview(navigationBar)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
}
