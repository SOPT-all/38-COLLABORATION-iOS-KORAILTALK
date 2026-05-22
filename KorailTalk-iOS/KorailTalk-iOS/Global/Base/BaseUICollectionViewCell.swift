//
//  BaseUICollectionViewCell.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/22/26.
//

import UIKit

class BaseUICollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
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
    
    // MARK: - Custom Methods
    
    func setStyle() {}
    
    func setUI() {}
    
    func setLayout() {}
}
