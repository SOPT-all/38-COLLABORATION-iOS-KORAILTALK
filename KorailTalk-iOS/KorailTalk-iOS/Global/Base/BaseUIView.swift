//
//  BaseUIViewController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

class BaseUIView: UIView {

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setStyle() {
        
        // TODO: - Color Asset 추가 후 색상 변경
        
        backgroundColor = .white
    }
    
    func setUI() {}
    
    func setLayout() {}
}
