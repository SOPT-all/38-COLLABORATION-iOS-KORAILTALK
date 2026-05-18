struct Seat: Identifiable {
    let number: Int
    let state: SeatState
    let hasOutlet: Bool

    var id: Int {
        number
    }
}
