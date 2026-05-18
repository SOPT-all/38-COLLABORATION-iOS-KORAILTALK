//
//  ReservationManager.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

final class ReservationManager {
    static let shared = ReservationManager()

    private let trainService: TrainServiceProtocol 

    init(trainService: TrainServiceProtocol = TrainService()) {
        self.trainService = trainService
    }
}
