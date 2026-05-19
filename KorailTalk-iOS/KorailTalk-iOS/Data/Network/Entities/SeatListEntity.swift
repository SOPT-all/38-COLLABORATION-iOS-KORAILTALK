//
//  SeatListEntity.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

// GET /api/v1/schedules/{scheduleId}/seats
struct SeatListEntity: Decodable {
    let scheduleId: Int
    let reservedSeats: [Int]
    let outletSeats: [Int]

    func toDomain() -> [Seat] {
        let reservedSeatNumbers = Set(reservedSeats)
        let outletSeatNumbers = Set(outletSeats)

        return (1 ... 72).map { seatNumber in
            Seat(
                number: seatNumber,
                state: reservedSeatNumbers.contains(seatNumber) ? .reserved : .available,
                hasOutlet: outletSeatNumbers.contains(seatNumber)
            )
        }
    }
}
