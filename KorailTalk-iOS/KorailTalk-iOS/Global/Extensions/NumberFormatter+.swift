//
//  NumberFormatter+.swift
//  KorailTalk-iOS
//
//  Created by mansuiki on 2026.05.18.
//

import Foundation

extension NumberFormatter {
    static func koreanDecimal(suffix: String? = "원") -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.numberStyle = .decimal
        formatter.positiveSuffix = suffix ?? ""
        formatter.negativeSuffix = suffix ?? ""
        return formatter
    }

    func string(from number: Int) -> String? {
        return string(from: NSNumber(value: number))
    }
}
