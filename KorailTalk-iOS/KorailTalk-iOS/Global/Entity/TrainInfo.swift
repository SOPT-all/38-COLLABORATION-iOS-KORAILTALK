import Foundation

struct TrainInfo {
    let type: TrainType
    let name: String
    let time: TrainTime
    let availability: TrainAvailability?
}

struct TrainTime {
    let departureTime: Date
    let arrivalTime: Date
}

struct TrainAvailability {
    let isSoldOut: Bool
    let isOutletSoldOut: Bool
}

enum TrainType: String {
    case ktx = "KTX"
    case ktxSancheon = "KTX-산천"
    case itxSaemaeul = "ITX-새마을"
    case mugunghwa = "무궁화호"

    var title: String {
        rawValue
    }
}
