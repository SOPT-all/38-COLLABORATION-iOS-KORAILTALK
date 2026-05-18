//
//  APIErrorCode.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

enum APIErrorCode: String, Decodable {
    case invalidRequest = "COMMON_001"
    case invalidInputValue = "COMMON_002"
    case methodNotAllowed = "COMMON_003"
    case internalServerError = "COMMON_004"
    case invalidTypeValue = "COMMON_005"
    case messageNotReadable = "COMMON_006"
    
    case scheduleNotFound = "SCHEDULE_001"
    
    case seatNotFound = "SEAT_001"
    case seatAlreadyReserved = "SEAT_002"
    case seatBlocked = "SEAT_003"
    
    case reservationNotFound = "RESERVATION_001"
    case reservationAlreadyCancelled = "RESERVATION_002"
    
    case unknown = "UNKNOWN"
    
    var defaultMessage: String {
        switch self {
        case .invalidRequest: return "잘못된 요청입니다."
        case .invalidInputValue: return "입력값이 올바르지 않습니다."
        case .methodNotAllowed: return "지원하지 않는 HTTP 메서드입니다."
        case .internalServerError: return "서버 내부 오류가 발생했습니다."
        case .invalidTypeValue: return "요청 값의 타입이 올바르지 않습니다."
        case .messageNotReadable: return "요청 본문(JSON) 형식이 올바르지 않습니다."
        case .scheduleNotFound: return "존재하지 않는 열차 일정입니다."
        case .seatNotFound: return "존재하지 않는 좌석입니다."
        case .seatAlreadyReserved: return "이미 예약된 좌석입니다. 다른 좌석을 선택해 주세요."
        case .seatBlocked: return "정책상 선택할 수 없는 좌석입니다."
        case .reservationNotFound: return "존재하지 않는 예약입니다."
        case .reservationAlreadyCancelled: return "이미 취소된 예약입니다."
        case .unknown: return "알 수 없는 에러가 발생했습니다."
        }
    }
}
