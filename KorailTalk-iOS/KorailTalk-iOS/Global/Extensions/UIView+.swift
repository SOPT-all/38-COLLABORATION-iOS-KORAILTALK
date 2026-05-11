//
//  UIView+.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/10/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func setCornerRadius(
        _ cornerRadius: CGFloat,
        maskedCorners: CACornerMask = [
            .layerMaxXMaxYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]
    ) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func setBorder(_ borderWidth: CGFloat = 1, borderColor: UIColor = .gray) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
//    var parentViewController: UIViewController? {
//        var responder: UIResponder? = self
//        
//        while let nextResponder = responder?.next {
//            responder = nextResponder
//            
//            if let viewController = nextResponder as? UIViewController {
//                return viewController
//            }
//        }
//        
//        return nil
//    }
}
