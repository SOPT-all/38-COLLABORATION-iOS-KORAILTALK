import Foundation

extension SeatSelectionModel {
    static let mock = SeatSelectionModel(
        train: TrainInfo(
            type: .mugunghwa,
            name: "무궁화호 1284",
            time: TrainTime(
                departureTime: Date(timeIntervalSince1970: 1778765400),
                arrivalTime: Date(timeIntervalSince1970: 1778772600)
            ),
            availability: TrainAvailability(isSoldOut: false, isOutletSoldOut: false)
        ),
        fare: TrainFare(
            general: SeatFare(type: .general, price: 12_300, isAvailable: true),
            special: SeatFare(type: .special, price: 45_600, isAvailable: true)
        ),
        cars: [
            TrainCar(
                number: 4,
                seatType: .general,
                seats: makeSeats(
                    selectedNumbers: [],
                    reservedNumbers: [5, 6, 7, 8, 17, 33, 34, 39, 44, 49, 58, 63],
                    outletNumbers: [1, 3, 17, 19, 21, 35, 42, 57]
                )
            )
        ]
    )

    private static func makeSeats(
        selectedNumbers: Set<Int>,
        reservedNumbers: Set<Int>,
        outletNumbers: Set<Int>
    ) -> [Seat] {
        (1 ... 72).map { number in
            Seat(
                number: number,
                state: seatState(
                    for: number,
                    selectedNumbers: selectedNumbers,
                    reservedNumbers: reservedNumbers
                ),
                hasOutlet: outletNumbers.contains(number)
            )
        }
    }

    private static func seatState(
        for number: Int,
        selectedNumbers: Set<Int>,
        reservedNumbers: Set<Int>
    ) -> SeatState {
        if selectedNumbers.contains(number) {
            return .selected
        }

        if reservedNumbers.contains(number) {
            return .reserved
        }

        return .available
    }
}
