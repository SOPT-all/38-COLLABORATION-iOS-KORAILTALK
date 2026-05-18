//
//  TrainModel.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/16/26.
//

import UIKit

struct TrainModel {
    let trainInfo: TrainInfo
    let fareInfo: TrainFare
    let hasOutletSeat: Bool
    
    var trainName: String {
        return trainInfo.name
    }
    
    var trainType: String {
        return trainInfo.type.title
    }
    
    var standardFareString: String {
        return formatNumber(fareInfo.general.price)
    }
    
    var specialFareString: String? {
        guard let specialPrice = fareInfo.special?.price
        else {
            return nil
        }
        
        return formatNumber(specialPrice)
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var departureTime: String {
        return formatDate(trainInfo.time.departureTime)
    }
    
    var arrivalTime: String {
        return formatDate(trainInfo.time.arrivalTime)
    }
    
    var durationTime: String {
        return formatDuration(from: trainInfo.time.departureTime, to: trainInfo.time.arrivalTime)
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

extension TrainModel {
    static func dummy() -> [TrainModel] {
        return [
            TrainModel(
                trainInfo: TrainInfo(
                    type: .ktx,
                    name: "KTX 001",
                    time: TrainTime(
                        departureTime: makeDate(hour: 6, minute: 0),
                        arrivalTime: makeDate(hour: 8, minute: 35)
                    ),
                    availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: false)
                ),
                fareInfo: TrainFare(
                    general: SeatFare(type: .general, price: 59_800, isAvailable: true),
                    special: SeatFare(type: .special, price: 83_700, isAvailable: true)
                ),
                hasOutletSeat: true
            ),
            TrainModel(
                trainInfo: TrainInfo(
                    type: .ktxSancheon,
                    name: "KTX-산천 402",
                    time: TrainTime(
                        departureTime: makeDate(hour: 7, minute: 15),
                        arrivalTime: makeDate(hour: 10, minute: 2)
                    ),
                    availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: true)
                ),
                fareInfo: TrainFare(
                    general: SeatFare(type: .general, price: 48_200, isAvailable: true),
                    special: SeatFare(type: .special, price: 65_000, isAvailable: true)
                ),
                hasOutletSeat: true
            ),
            TrainModel(
                trainInfo: TrainInfo(
                    type: .itxSaemaeul,
                    name: "ITX-새마을 1101",
                    time: TrainTime(
                        departureTime: makeDate(hour: 8, minute: 30),
                        arrivalTime: makeDate(hour: 12, minute: 45)
                    ),
                    availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: false)
                ),
                fareInfo: TrainFare(
                    general: SeatFare(type: .general, price: 34_600, isAvailable: true),
                    special: nil
                ),
                hasOutletSeat: false
            ),
            TrainModel(
                trainInfo: TrainInfo(
                    type: .mugunghwa,
                    name: "무궁화호 1205",
                    time: TrainTime(
                        departureTime: makeDate(hour: 9, minute: 10),
                        arrivalTime: makeDate(hour: 14, minute: 20)
                    ),
                    availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: false)
                ),
                fareInfo: TrainFare(
                    general: SeatFare(type: .general, price: 28_600, isAvailable: true),
                    special: nil
                ),
                hasOutletSeat: false
            ),
            TrainModel(
                trainInfo: TrainInfo(
                    type: .ktx,
                    name: "KTX 023",
                    time: TrainTime(
                        departureTime: makeDate(hour: 11, minute: 55),
                        arrivalTime: makeDate(hour: 14, minute: 30)
                    ),
                    availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: false)
                ),
                fareInfo: TrainFare(
                    general: SeatFare(type: .general, price: 59_800, isAvailable: true),
                    special: SeatFare(type: .special, price: 83_700, isAvailable: true)
                ),
                hasOutletSeat: true
            )
        ]
    }
    
    private static func makeDate(hour: Int, minute: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        
        return Calendar.current.date(from: components) ?? Date()
    }
}

