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
    private let dropdownView = DropdownView(
        items:["일반석","콘센트석","유아동반","수동휠체어","전동휠체어","2층석","자전거","대피도우미"],
        placeholder: "일반석"
    )
    
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
            $0.configure(title: "승차권 조회", showsRefreshButton: true)
            $0.backButtonAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func setUI() {
        view.addSubviews(navigationBar, dropdownView)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        dropdownView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(92)
        }
    }
}
