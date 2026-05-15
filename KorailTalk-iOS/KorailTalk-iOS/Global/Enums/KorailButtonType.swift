//
//  KorailButtonType.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import Foundation

enum KorailButtonType {
    case primary, outline, ticket, confirm
    
    var radius: CGFloat {
        switch self {
        case .primary, .outline: return 10
        case .ticket, .confirm: return 15
        }
    }
    
    var title: String? {
        switch self {
        case .primary: return "결제하기"
        case .ticket: return "나의 티켓 보러가기"
        case .confirm: return "확인 완료"
        case .outline: return nil
        }
    }
}
