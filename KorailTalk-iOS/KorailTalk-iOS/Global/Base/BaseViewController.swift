//
//  BaseViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

import SnapKit

class BaseUIViewController: UIViewController {
    
    // MARK: - Properties
    
    let navigationBar = TopNavigationBar()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetUI()
        baseSetLayout()
        baseSetAddTarget()
        
        setStyle()
        setUI()
        setLayout()
        setAddTarget()
        setDelegate()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Setup Methods
    
    private func baseSetUI() {
        view.addSubview(navigationBar)
    }
    
    private func baseSetLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(statusBarHeight + 60)
        }
    }
    
    private func baseSetAddTarget() {
        navigationBar.backButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func setStyle() {
        view.backgroundColor = .surfaceDefault
    }
    
    func setUI() {}
    
    func setLayout() {}
    
    func setAddTarget() {}
    
    func setDelegate() {}
    
    func setRegister() {}
}
