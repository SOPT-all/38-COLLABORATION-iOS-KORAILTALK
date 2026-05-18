//
//  APIConfiguration.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

enum APIConfiguration {
    case fetchSchedules
    case fetchSeats(scheduleId: Int)
    case reserveSeats
    case fetchMyReservations(userId: Int)
    
    private var baseURL: String {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("🚨 Info.plist에 BASE_URL이 설정되지 않았습니다.")
        }
        return urlString
    }
    
    private var path: String {
        switch self {
        case .fetchSchedules:
            return "/schedules"
        case .fetchSeats(let scheduleId):
            return "/schedules/\(scheduleId)/seats"
        case .reserveSeats:
            return "/reservations"
        case .fetchMyReservations(let userId):
            return "/users/\(userId)/reservations"
        }
    }
    
    var urlString: String {
        return baseURL + path
    }
}
