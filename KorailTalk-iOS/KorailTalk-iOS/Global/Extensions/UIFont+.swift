//
//  UIFont+.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

extension UIFont {
    static func pretendard(_ style: Pretendard) -> UIFont {
        return UIFont(name: style.weight, size: style.size) ?? .systemFont(ofSize: style.size)
    }
    
    enum Pretendard {
        case header1, header2, header3, header4
        case body1, body2, body3, body4
        case caption1, caption2, caption3
        
        var weight: String {
            switch self {
            case .header1, .header2, .header3, .header4:
                "Pretendard-SemiBold"
            case .body1, .body2, .body3, .caption1:
                "Pretendard-Medium"
            case .body4, .caption2, .caption3:
                "Pretendard-Regular"
            }
        }
        
        var size: CGFloat {
            switch self {
            case .header1: 24
            case .header2, .body1: 20
            case .header4: 18
            case .header3, .body2: 16
            case .body3, .body4: 14
            case .caption1, .caption2: 12
            case .caption3: 10
            }
        }
        
        var tracking: CGFloat {
            return CGFloat(-1) / 100 * size
        }
        
        var lineHeight: CGFloat {
            return size
        }
    }
}
