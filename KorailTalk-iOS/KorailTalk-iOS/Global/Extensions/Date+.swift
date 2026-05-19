//
//  Date+.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import Foundation

extension Date {
    /// "2026년 5월 19일 (화)"
    var toKoreanFullDateString: String {
        return DateFormatter.koreanFullDate.string(from: self)
    }
    
    /// "HH: mm"
    var toTimeString: String {
        return DateFormatter.timeOnly.string(from: self)
    }
}

private extension DateFormatter {
    static let koreanFullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH: mm"
        return formatter
    }()
}
