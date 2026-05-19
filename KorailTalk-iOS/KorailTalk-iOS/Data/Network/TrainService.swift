//
//  TrainService.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

final class TrainService: BaseService, TrainServiceProtocol {
    func fetchSchedules(completion: @escaping (Result<[TrainInfo], any Error>) -> Void) {
        
    }
    
    func fetchSeats(scheduleId: Int, completion: @escaping (Result<[Seat], any Error>) -> Void) {
        
    }
    
    func reserveSeats(scheduleId: Int, userId: Int, seatNumbers: [Int], completion: @escaping (Result<Reservation, any Error>) -> Void) {
        let url = APIConfiguration.reserveSeats.urlString
        
        let requestBody = ReservationRequestEntity(
            scheduleId: scheduleId,
            userId: userId,
            seatNumbers: seatNumbers
        )
        
        request(urlString: url, method: "POST", body: requestBody) { (result: Result<ReservationDataEntity, Error>) in
            switch result {
            case .success(let entity):
                let domainReservation = entity.toDomain()
                completion(.success(domainReservation))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func fetchMyReservations(userId: Int, completion: @escaping (Result<[Reservation], any Error>) -> Void) {
        let url = APIConfiguration.fetchMyReservations(userId: userId).urlString
        
        request(urlString: url, method: "GET") { (result: Result<MyReservationListEntity, Error>) in
            switch result {
            case .success(let entity):
                let domainReservations = entity.reservations.map { $0.toDomain() }
                completion(.success(domainReservations))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
