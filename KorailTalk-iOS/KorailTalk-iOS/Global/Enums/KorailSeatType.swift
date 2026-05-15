//
//  SeatType.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/15/26.
//
import UIKit

enum KorailSeatType {
    case standard, special
    
    var radius: CGFloat {
        return 8
    }
    
    var title: String {
        switch self {
        case .standard: return "일반석"
        case .special: return "특별석"
        }
    }
    
    var fare: Int? {
        switch self {
        case .standard: return 34700
        case .special: return 61700
        }
    }
}
