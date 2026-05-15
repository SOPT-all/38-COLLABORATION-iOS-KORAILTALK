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
    
    private let dropdownView = DropdownView(
        items: [
            "일반석",
            "콘센트석",
            "유아동반",
            "수동휠체어",
            "전동휠체어",
            "2층석",
            "자전거",
            "대피도우미"
        ],
        placeholder: "일반석"
    )
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        super.setStyle()
        
        navigationBar.configure(
            title: "승차권 조회",
            showsRefreshButton: true
        )
    }
    
    override func setUI() {
        view.addSubview(dropdownView)
    }
    
    override func setLayout() {
        dropdownView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(92)
            $0.height.equalTo(28)
        }
    }
}
