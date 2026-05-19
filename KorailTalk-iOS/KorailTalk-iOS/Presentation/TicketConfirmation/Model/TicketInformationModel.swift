//
//  TicketInformationModel.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/19/26.
//

import Foundation

struct TicketInformationModel {
    let trainName: String
    let departureTime: String
    let arrivalTime: String
    let seatInfo: String
    let totalTicketCount: Int
    
    init(scheduleInfo: ScheduleInfo, selectedSeats: [Seat]) {
        let trainInfo = scheduleInfo.trainInfo
        
        self.trainName = trainInfo.name
        self.departureTime = trainInfo.time.departureTime.toTimeString
        self.arrivalTime = trainInfo.time.arrivalTime.toTimeString
        
        let seatsString = selectedSeats
            .map { $0.number }
            .sorted()
            .map { number -> String in
                let letter = (number % 2 == 1) ? "A" : "B"
                return "\(number)\(letter)"
            }
            .joined(separator: " ")
        
        self.seatInfo = "일반실 4호차 \(seatsString)"
        self.totalTicketCount = selectedSeats.count
    }
}
