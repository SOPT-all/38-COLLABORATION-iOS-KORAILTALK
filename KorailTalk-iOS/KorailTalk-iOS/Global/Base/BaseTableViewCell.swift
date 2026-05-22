//
//  BaseTableViewCell.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/22/26.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    func setStyle() {}
    
    func setUI() {}
    
    func setLayout() {}
    
    func setAddTarget() {}
}

