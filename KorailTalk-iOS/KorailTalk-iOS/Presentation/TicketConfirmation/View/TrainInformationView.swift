//
//  TicketInfoView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/15/26.
//

//seatInfoStackView
// ├─ roomLabel
// ├─ carLabel
// ├─ seatLabel
// └─ directionLabel

import UIKit

import SnapKit
import Then

class TrainInformationView: BaseUIView {
    
    // MARK: - UI Component
    private let trainInformationStackView = UIStackView() //전체
    private let trainDateStackView = UIStackView() //2026 4 24 금
    private let ktxInformationStackView = UIStackView() //ktx 581 용산 07:43 -> 순천 10:59 간격 5
    private let seatInformationStackView = UIStackView() //일반실 16호차 5B 역방향
    
    private let departureTimeView = UILabel() // 07:43 간격 4
    private let arrivalTimeView = UILabel() //10:59 간격 4
    
    private let yearLabel = UILabel() //2026년
    private let monthLabel = UILabel() //4월
    private let dayLabel = UILabel() //24월
    private let dayOfWeekLabel = UILabel() //(금)
    
    private let trainNumberLabel = UILabel() //ktx 581
    private let departureTimeLabel = UILabel() //07 : 43
    private let arrivalTimeLabel = UILabel() //10 : 59
    
    private let roomLabel = UILabel() //일반실
    private let carLabel = UILabel() //16호차
    private let seatLabel = UILabel() //5B
    private let directionLabel = UILabel() //역방향
    
    private let ticketNumberLabel = UILabel() //2매
    private let arrowIcon = UIImageView(image: UIImage(asset: .arrowRight))


    private let firstSmallTag = StationTag(type: .small, title: "용산")
    private let secondSmallTag = StationTag(type: .small, title: "순천")
    
    override func setStyle() {

        trainInformationStackView.do {
            $0.axis = .vertical
            $0.spacing = 5
        }
        
        trainDateStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        ktxInformationStackView.do{
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        trainNumberLabel.do {
            $0.text = "[ktx 581]"
        }
        
        departureTimeView.do {
            $0.text = "07 : 43"
        }
        
        arrivalTimeView.do {
            $0.text = "10 : 59"
        }
        
        seatInformationStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        roomLabel.do {
            $0.text = "일반실"
        }
        
        carLabel.do {
            $0.text = "16호차"
        }
        
        seatLabel.do {
            $0.text = "5B"
        }
        
        directionLabel.do {
            $0.text = "역방향"
        }
        
        
    }
}
