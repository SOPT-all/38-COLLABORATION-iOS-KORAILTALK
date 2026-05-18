struct Reservation: Identifiable {
    let id: Int
    let train: TrainInfo
    let seats: [Seat]
}
