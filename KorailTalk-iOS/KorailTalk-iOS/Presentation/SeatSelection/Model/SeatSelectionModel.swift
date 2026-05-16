struct SeatSelectionModel {
    let train: TrainInfo
    let fare: TrainFare
    let cars: [TrainCar]

    var currentCar: TrainCar? {
        cars.first
    }
    
    var carDropdownItems: [String] {
        cars.map { $0.title }
    }
    
    var currentCarTitle: String {
        currentCar?.title ?? ""
    }
    
    var trainTitle: String {
        guard let currentCar else {
            return train.name
        }
        
        return "\(train.name) (\(currentCar.seatType.title))"
    }
    
    var remainingSeatText: String {
        guard let currentCar else {
            return "잔여 -석 | 전체 -석"
        }
        
        return "잔여 \(currentCar.remainingSeatCount)석 | 전체 \(currentCar.totalSeatCount)석"
    }
    
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
    
    var title: String {
        "\(number)호차/\(seatType.title)"
    }
    
    var totalSeatCount: Int {
        seats.count
    }
    
    var remainingSeatCount: Int {
        seats.filter { $0.state != .reserved }.count
    }
}
