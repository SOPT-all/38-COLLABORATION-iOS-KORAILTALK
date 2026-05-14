//
//  StationTagType.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

enum StationTagType {
    case small, large
    
    var padding: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        case .large:
            return UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .small:
            return .neutral200
        case .large:
            return .primary100
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small:
            return 5
        case .large:
            return 6
        }
    }
}
