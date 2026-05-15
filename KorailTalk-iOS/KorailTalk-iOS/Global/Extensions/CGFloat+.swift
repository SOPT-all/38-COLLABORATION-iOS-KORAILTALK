//
//  CGFloat+.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/15/26.
//

import UIKit

extension CGFloat {
    static var currentScreenWidth: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.screen.bounds.width ?? 375
    }
    
    static var currentScreenHeight: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.screen.bounds.height ?? 812
    }

    var adjustedW: CGFloat {
        let ratio: CGFloat = CGFloat.currentScreenWidth / 375
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = CGFloat.currentScreenHeight / 812
        return self * ratio
    }
}

extension Double {
    var adjustedW: Double {
        return Double(CGFloat(self).adjustedW)
    }
    
    var adjustedH: Double {
        return Double(CGFloat(self).adjustedH)
    }
}

extension Int {
    var adjustedW: CGFloat {
        return CGFloat(self).adjustedW
    }
    
    var adjustedH: CGFloat {
        return CGFloat(self).adjustedH
    }
}
