//
//  TrainService.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

final class TrainService: BaseService, TrainServiceProtocol {
    func fetchSchedules(completion: @escaping (Result<[ScheduleInfo], any Error>) -> Void) {
        
    }
    
    func fetchSeats(scheduleId: Int, completion: @escaping (Result<[Seat], any Error>) -> Void) {
        request(
            urlString: APIConfiguration.fetchSeats(scheduleId: scheduleId).urlString
        ) { (result: Result<SeatListEntity, Error>) in
            switch result {
            case .success(let entity):
                completion(.success(entity.toDomain()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func reserveSeats(scheduleId: Int, userId: Int, seatNumbers: [Int], completion: @escaping (Result<Reservation, any Error>) -> Void) {
        
    }
    
    func fetchMyReservations(userId: Int, completion: @escaping (Result<[Reservation], any Error>) -> Void) {
        
    }
}
