struct Seat: Identifiable {
    let number: Int
    let state: SeatState
    let hasOutlet: Bool

    var id: Int {
        number
    }
}

enum SeatState {
    case available
    case selected
    case reserved
}
