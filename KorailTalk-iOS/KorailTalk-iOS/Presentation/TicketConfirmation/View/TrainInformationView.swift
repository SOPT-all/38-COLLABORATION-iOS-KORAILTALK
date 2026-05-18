//
//  TrainInformationView.swift
//  KorailTalk-iOS
//
//  Created by 김세령 on 5/15/26.
//

import UIKit

import SnapKit
import Then

class TrainInformationView: BaseUIView {
    
    // MARK: - UI Component
    
    private let trainInformationStackView = UIStackView()
    private let trainDateStackView = UIStackView()
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let dayLabel = UILabel()
    private let dayOfWeekLabel = UILabel()
    private let ktxInformationStackView = UIStackView()
    private let trainNumberLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let roomLabel = UILabel()
    private let arrowIcon = UILabel()
    private let departureSmallTag = StationTag(type: .small, title: "용산")
    private let arrivalSmallTag = StationTag(type: .small, title: "순천")
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)

        trainInformationStackView.do {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .leading
            $0.distribution = .fill
        }
        
        trainDateStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        ktxInformationStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }
        
        yearLabel.do {
            $0.text = "2026년"
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }

        monthLabel.do {
            $0.text = "4월"
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }

        dayLabel.do {
            $0.text = "24일"
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }

        dayOfWeekLabel.do {
            $0.text = "(금)"
            $0.font = .pretendard(.body3)
            $0.textColor = .secondary700
        }

        trainNumberLabel.do {
            $0.text = "[KTX 581]"
            $0.font = .pretendard(.body3)
            $0.textColor = .black
        }

        departureTimeLabel.do {
            $0.text = "07 : 43"
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral900
        }

        arrivalTimeLabel.do {
            $0.text = "10 : 59"
            $0.font = .pretendard(.body3)
            $0.textColor = .neutral900
        }

        roomLabel.do {
            $0.text = "일반실  16호차  5B  역방향"
            $0.font = .pretendard(.caption1)
            $0.textColor = .neutral700
        }

        arrowIcon.do {
            $0.text = "→"
            $0.font = .pretendard(.body3)
            $0.textColor = .black
        }
    }
    
    override func setUI() {
        addSubview(trainInformationStackView)
        
        trainDateStackView.addArrangedSubviews(yearLabel, monthLabel, dayLabel, dayOfWeekLabel)
        
        ktxInformationStackView.addArrangedSubviews(trainNumberLabel, departureSmallTag, departureTimeLabel, arrowIcon, arrivalSmallTag, arrivalTimeLabel
        )
        
        trainInformationStackView.addArrangedSubviews(trainDateStackView, ktxInformationStackView, roomLabel
        )
    }
    
    override func setLayout() {
        trainInformationStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
}
