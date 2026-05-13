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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Setup Methods
    
    func setStyle() {
        view.backgroundColor = .surfaceDefault
    }
    
    func setUI() {}
    
    func setLayout() {}
    
    func setAddTarget() {}
    
    func setDelegate() {}
    
}
