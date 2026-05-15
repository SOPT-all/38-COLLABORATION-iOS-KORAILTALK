//
//  TrainModel.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/16/26.
//

import UIKit

struct TrainModel {
    let trainName: String
    let departureTime: String
    let arrivalTime: String
    let durationTime: String
    let benefitText: String?
    let standardFare: Int
    let specialFare: Int
    
    var standardFareString: String {
        return formatNumber(standardFare)
    }
    
    var specialFareString: String {
        return formatNumber(specialFare)
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

extension TrainModel {
    static func dummy() -> [TrainModel] {
        return [
            TrainModel(trainName: "KTX 001", departureTime: "06:00", arrivalTime: "08:35", durationTime: "2시간 35분", benefitText: "5% 적립", standardFare: 59800, specialFare: 83700),
            TrainModel(trainName: "KTX-산천 402", departureTime: "07:15", arrivalTime: "10:02", durationTime: "2시간 47분", benefitText: "임산부 할인", standardFare: 48200, specialFare: 65000),
            TrainModel(trainName: "ITX-마음 1101", departureTime: "08:30", arrivalTime: "12:45", durationTime: "4시간 15분", benefitText: nil, standardFare: 34600, specialFare: 52000),
            TrainModel(trainName: "무궁화호 1205", departureTime: "09:10", arrivalTime: "14:20", durationTime: "5시간 10분", benefitText: "최저가", standardFare: 28600, specialFare: 41000),
            TrainModel(trainName: "SRT 305", departureTime: "10:40", arrivalTime: "13:12", durationTime: "2시간 32분", benefitText: "쿠폰사용가능", standardFare: 52500, specialFare: 76000),
            TrainModel(trainName: "KTX 023", departureTime: "11:55", arrivalTime: "14:30", durationTime: "2시간 35분", benefitText: nil, standardFare: 59800, specialFare: 83700)
        ]
    }
}
