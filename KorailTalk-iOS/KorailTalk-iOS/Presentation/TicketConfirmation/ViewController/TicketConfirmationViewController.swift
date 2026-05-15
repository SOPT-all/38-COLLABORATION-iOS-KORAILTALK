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
        
    }
    
    override func setLayout() {

    }
}
