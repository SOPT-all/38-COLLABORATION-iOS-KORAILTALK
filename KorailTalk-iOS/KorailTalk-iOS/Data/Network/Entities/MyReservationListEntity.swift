//
//  MyReservationListEntity.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

// GET /api/v1/users/{userId}/reservations

struct MyReservationListEntity: Decodable {
    let reservations: [MyReservationEntity]
}

struct MyReservationEntity: Decodable {
    let scheduleId: Int
    let trainType: String
    let trainName: String
    let departureTime: Date
    let arrivalTime: Date
    let seatNumbers: [Int]
    let totalPrice: Int
    
    func toDomain() -> Reservation {
        let train = TrainInfo(
            type: TrainType(rawValue: trainType) ?? .ktx,
            name: trainName,
            time: TrainTime(departureTime: departureTime, arrivalTime: arrivalTime),
            availability: nil
        )
        let seats = seatNumbers.map { Seat(number: $0, state: .reserved, hasOutlet: false) }
        
        return Reservation(
            id: scheduleId,
            train: train,
            seats: seats
        )
    }
}
