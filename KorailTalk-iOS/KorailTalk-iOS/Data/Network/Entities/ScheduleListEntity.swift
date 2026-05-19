//
//  ScheduleListEntity.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

struct ScheduledListEntity: Decodable {
    let schedules: [ScheduledEntity]
}

struct ScheduleInfo {
    let scheduleId: Int
    let trainInfo: TrainInfo
    let trainFare: TrainFare
}

struct ScheduledEntity: Decodable {
    let scheduleId: Int
    let trainType: String
    let trainName: String
    let departureTime: Date
    let arrivalTime: Date
    let generalPrice: Int
    let specialPrice: Int
    let isSoldOut: Bool
    let isOutletSoldOut: Bool
    
    func toDomain() -> ScheduleInfo {
        let train = TrainInfo(
            type: TrainType(rawValue: trainType) ?? .ktx,
            name: trainName,
            time: TrainTime(departureTime: departureTime, arrivalTime: arrivalTime),
            availability: TrainAvailability(isSoldOut: isSoldOut, isOutletSoldOut: isOutletSoldOut)
        )
        
        let specialFare: SeatFare? = specialPrice == 0 ? nil : SeatFare(
            type: .special,
            price: specialPrice,
            isAvailable: true
        )
        
        let fare = TrainFare(
            general: SeatFare(type: .general, price: generalPrice, isAvailable: true),
            special: specialFare
        )
        
        return ScheduleInfo(
            scheduleId: scheduleId,
            trainInfo: train,
            trainFare: fare
        )
    }
}
