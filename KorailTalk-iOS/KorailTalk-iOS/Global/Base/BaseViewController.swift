//
//  BaseViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        setAddTarget()
        setDelegate()
    }
    
    // MARK: - Setup Methods
    
    func setStyle() {
        
        // TODO: - Color Asset 추가 후 색상 변경
        
        view.backgroundColor = .white
    }
    
    func setUI() {}
    
    func setLayout() {}
    
    func setAddTarget() {}
    
    func setDelegate() {}
}
