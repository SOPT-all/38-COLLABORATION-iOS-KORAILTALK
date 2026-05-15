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
