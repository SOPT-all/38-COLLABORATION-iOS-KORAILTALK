//
//  TrainModel.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/16/26.
//

import UIKit

struct TrainModel {
    let scheduleId: Int
    let trainInfo: TrainInfo
    let fareInfo: TrainFare
    let hasOutletSeat: Bool

    var departureTime: String {
        return formatDate(trainInfo.time.departureTime)
    }
    
    var arrivalTime: String {
        return formatDate(trainInfo.time.arrivalTime)
    }
    
    var durationTime: String {
        return formatDuration(from: trainInfo.time.departureTime, to: trainInfo.time.arrivalTime)
    }
    
    var canSelectOutletSeat: Bool {
        guard let availability = trainInfo.availability else {
            return false
        }

        return hasOutletSeat && !availability.isOutletSoldOut
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func formatDuration(from departureTime: Date, to arrivalTime: Date) -> String {
        let totalMinutes = Int(arrivalTime.timeIntervalSince(departureTime) / 60)
        return "\(totalMinutes / 60)시간 \(totalMinutes % 60)분"
    }
}
