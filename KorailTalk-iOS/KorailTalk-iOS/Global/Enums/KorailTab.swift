//
//  KorailTab.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/13/26.
//

import UIKit

enum KorailTab: Int, CaseIterable {
    case home
    case benefit
    case travel
    case myticket
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .benefit:
            return "혜택 · 정기권"
        case .travel:
            return "상품 · 패스"
        case .myticket:
            return "나의 티켓"
        }
    }
    
    var image: UIImage {
        switch self {
        case .home:
            return .icHome
        case .benefit:
            return .icBenefit
        case .travel:
            return .icTravelpass
        case .myticket:
            return .icMyticket
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return .icHomeActive
        case .benefit, .travel:
            return nil
        case .myticket:
            return .icMyticketActive
        }
    }
    
    var viewController: UIViewController? {
        switch self {
        case .home:
            return TrainSearchViewController()
        case .benefit, .travel:
            return nil
        case .myticket:
            return MyTicketViewController()
        }
    }
}
