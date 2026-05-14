struct TrainFare {
    let general: SeatFare
    let special: SeatFare?
}

struct SeatFare {
    let type: SeatType
    let price: Int
    let isAvailable: Bool
}

enum SeatType {
    case general
    case special

    var title: String {
        switch self {
        case .general:
            return "일반석"
        case .special:
            return "특별석"
        }
    }
}
