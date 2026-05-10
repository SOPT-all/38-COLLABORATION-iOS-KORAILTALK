//
//  UIStackView+.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/10/26.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
