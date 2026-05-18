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
        
    }
    
    func fetchMyReservations(userId: Int, completion: @escaping (Result<[Reservation], any Error>) -> Void) {
        
    }
}
