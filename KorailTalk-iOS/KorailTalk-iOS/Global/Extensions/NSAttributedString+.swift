//
//  NSAttributedString+.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/10/26.
//

import UIKit

extension NSAttributedString {
    static func pretendardString(
        _ text: String = "",
        style: UIFont.Pretendard
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = style.lineHeight
        paragraphStyle.minimumLineHeight = style.lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.pretendard(style),
            .kern: style.tracking
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
