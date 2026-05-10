//
//  UIView+.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/10/26.
//

import UIKit

extension UIView {
    /// addSubview의 복수형 함수입니다
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    /// cornerRadius를 설정하는 함수입니다
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
    
    /// border를 설정하는 함수입니다
    func setBorder(_ borderWidth: CGFloat = 1, borderColor: UIColor = .gray) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
