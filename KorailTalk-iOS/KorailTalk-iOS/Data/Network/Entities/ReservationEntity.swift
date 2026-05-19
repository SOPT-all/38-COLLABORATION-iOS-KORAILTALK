//
//  ReservationEntity.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

// POST /api/v1/reservations

struct ReservationRequestEntity: Encodable {
    let scheduleId: Int
    let userId: Int
    let seatNumbers: [Int]
}

struct ReservationResponseEntity: Decodable {
    let message: String
    let data: ReservationDataEntity
}

struct ReservationDataEntity: Decodable {
    let scheduleId: Int
    let userId: Int
    let seatNumbers: [Int]
}
