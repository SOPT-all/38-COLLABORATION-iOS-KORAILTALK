//
//  TrainServiceProtocol.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

protocol TrainServiceProtocol {
    
    /// 1. 열차편 조회 (GET /api/v1/schedules)
    func fetchSchedules(
        completion: @escaping (Result<[ScheduleInfo], Error>) -> Void
    )
    
    /// 2. 열차 좌석 조회 (GET /api/v1/schedules/{scheduleId}/seats)
    func fetchSeats(
        scheduleId: Int,
        completion: @escaping (Result<[Seat], Error>) -> Void
    )
    
    /// 3. 열차 좌석 예약 (POST /api/v1/reservations)
    func reserveSeats(
        scheduleId: Int,
        userId: Int,
        seatNumbers: [Int],
        completion: @escaping (Result<Reservation, Error>) -> Void
    )
    
    /// 4. 예매 내역 조회 (GET /api/v1/users/{userId}/reservations)
    func fetchMyReservations(
        userId: Int,
        completion: @escaping (Result<[Reservation], Error>) -> Void
    )
}
