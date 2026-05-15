struct SeatSelectionModel {
    let train: TrainInfo
    let fare: TrainFare
    let cars: [TrainCar]

    var selectedSeats: [Seat] {
        cars.flatMap { $0.selectedSeats }
    }

    var selectedSeatCount: Int {
        selectedSeats.count
    }

    var selectedSeatFare: SeatFare? {
        guard let selectedCar = cars.first(where: { $0.selectedSeatCount > 0 }) ?? cars.first else {
            return nil
        }
        
        return seatFare(for: selectedCar.seatType)
    }

    var totalPrice: Int {
        cars.reduce(0) { totalPrice, car in
            guard let seatFare = seatFare(for: car.seatType) else {
                return totalPrice
            }
            
            return totalPrice + seatFare.price * car.selectedSeatCount
        }
    }
    
    private func seatFare(for seatType: SeatType) -> SeatFare? {
        switch seatType {
        case .general:
            return fare.general
        case .special:
            return fare.special
        }
    }
}

struct TrainCar: Identifiable {
    let number: Int
    let seatType: SeatType
    let seats: [Seat]

    var id: Int {
        number
    }
    
    var selectedSeats: [Seat] {
        seats.filter { $0.state == .selected }
    }
    
    var selectedSeatCount: Int {
        selectedSeats.count
    }
}
