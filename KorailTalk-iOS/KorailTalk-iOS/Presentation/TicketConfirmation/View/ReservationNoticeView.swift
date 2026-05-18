//
//  ReservationNoticeView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/18/26.
//

import UIKit

import SnapKit
import Then

class ReservationNoticeView: BaseUIView {
    
    // MARK: - UI Components
    
    private let checkStackView = UIStackView()
    private let checkTitleStackView = UIStackView()
    private let checkImageView = UIImageView()
    private let checkTitleLabel = UILabel()
    private let checkContentStackView = UIStackView()
    private let checkFirstContentLabel = UILabel()
    private let checkSecondContentLabel = UILabel()
    
    private let transferStackView = UIStackView()
    private let transferTitleStackView = UIStackView()
    private let transferImageView = UIImageView()
    private let transferTitleLabel = UILabel()
    private let transferContentLabel = UILabel()
    
    private let bottomButtonStackView = UIStackView()
    private let refundPenaltyButton =
        GuideButton(title: "승차권 환불 위약금 확인")
    private let baggageGuideButton =
        GuideButton(title: "열차 내 물품 휴대기준 확인")
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        checkStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
        }
        
        checkTitleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
        }
        
        checkImageView.do {
            $0.image = .icCheck
        }
        
        checkTitleLabel.do {
            $0.text = "꼭 알아주세요!"
            $0.font = .pretendard(.header3)
            $0.textColor = .black
        }
        
        checkContentStackView.do {
            $0.axis = .vertical
            $0.spacing = 5
        }
        
        checkFirstContentLabel.do {
            $0.text = "승차권 캡처/사진 이용 탑승은 부정승차로 간주 부가운임 부과"
            $0.font = .pretendard(.body4)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
        
        checkSecondContentLabel.do {
            $0.text =
            """
            할인 승차권을 구매하신 고객님은 열차 탑승시 신분증 또는
            증명서 휴대
            """
            $0.font = .pretendard(.body4)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
        
        transferStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
        }

        transferTitleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
        }

        transferImageView.do {
            $0.image = .icExclamation
        }

        transferTitleLabel.do {
            $0.text = "승차군 전달하기 서비스 제외 기준"
            $0.font = .pretendard(.header3)
            $0.textColor = .black
        }

        transferContentLabel.do {
            $0.text =
            """
            좌석을 지정하지 않은 입석, 자유석 승차권
            본인만 사용 가능한 할인 상품
            힘내라 청춘, 청소년드림, 정기 승차권 등
            반려동물 동반 으로 좌석이 필요한 경우 어른 승차권 구매
            """
            $0.font = .pretendard(.body4)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
        
        bottomButtonStackView.do {
            $0.axis = .vertical
            $0.spacing = 1
        }
    }
    
    override func setUI() {
        checkStackView.addArrangedSubviews(checkTitleStackView, checkContentStackView)
        
        checkTitleStackView.addArrangedSubviews(<#T##views: UIView...##UIView#>)
    }
    

    
    // MARK: - Public Methods



}
