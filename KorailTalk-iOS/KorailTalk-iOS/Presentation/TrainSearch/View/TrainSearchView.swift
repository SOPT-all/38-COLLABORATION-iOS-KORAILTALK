//
//  TrainSearchView.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/15/26.
//
import UIKit

import SnapKit
import Then

final class TrainSearchView: BaseUIView {
    
    // MARK: - Properties
    
    var trainTypeDidSelect: ((String) -> Void)? {
        didSet {
            firstDropdownView.onItemSelected = trainTypeDidSelect
        }
    }
    
    var seatOptionDidSelect: ((String) -> Void)? {
        didSet {
            secondDropdownView.onItemSelected = seatOptionDidSelect
        }
    }
    
    // MARK: - UI Components
    
    private let departureLabel = UILabel()
    private let arrivalLabel = UILabel()
    private let arrowImage = UIImageView()
    private let titleStackView = UIStackView()
    
    private let dateStackView = UIStackView()
    private let backButton = UIButton()
    private let nextButton = UIButton()
    private let dateLabel = UILabel()
    
    private let dropDownStackView = UIStackView()
    private let firstDropdownView = DropdownView(
        items: ["전체", "무궁화호", "새마을호", "itx", "ktx", "srt"], placeholder: "전체"
    )
    private let secondDropdownView = DropdownView(
        items: [ "일반석", "콘센트석", "유아동반", "수동휠체어", "전동휠체어", "2층석", "자전거", "대피도우미"], placeholder: "일반석"
    )
    private let thirdDropdownView = DropdownView(
        items: ["직통"], placeholder: "직통"
    )
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        backgroundColor = .neutral100
        
        titleStackView.do {
            $0.spacing = 60
            $0.axis = .horizontal
        }
        
        arrowImage.do {
            $0.image = .icArrowBlue
        }
        
        departureLabel.do {
            $0.text = "용산"
            $0.font = .pretendard(.header1)
            $0.textColor = .secondary700
            $0.textAlignment = .center
        }
        
        arrivalLabel.do {
            $0.text = "순천"
            $0.font = .pretendard(.header1)
            $0.textColor = .secondary700
            $0.textAlignment = .center
        }
        
        dateStackView.do {
            $0.spacing = 55
            $0.axis = .horizontal
        }
        
        dateLabel.do {
            $0.text = "2026년  5월 10일 (일)"
            $0.font = .pretendard(.body2)
            $0.textColor = .neutral900
            $0.textAlignment = .center
            $0.lineBreakMode = .byClipping
        }
        
        backButton.do {
            $0.setImage(.icPrevious, for: .normal)
        }
        
        nextButton.do {
            $0.setImage(.icNextActive, for: .normal)
        }
        
        dropDownStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .top
        }
        
        tableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setUI() {
        titleStackView.addArrangedSubviews(departureLabel, arrivalLabel)
        dateStackView.addArrangedSubviews(backButton, dateLabel, nextButton)
        dropDownStackView.addArrangedSubviews(firstDropdownView, secondDropdownView, thirdDropdownView)
        addSubviews(tableView, titleStackView, arrowImage, dateStackView, dropDownStackView)
    }
    
    override func setLayout() {
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.centerX.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(12)
            $0.centerY.equalTo(titleStackView)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        nextButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(1)
            $0.horizontalEdges.equalToSuperview().inset(18.5)
        }
        
        dateLabel.snp.makeConstraints {
            $0.width.equalTo(141)
        }
        
        dropDownStackView.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(7)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        firstDropdownView.snp.makeConstraints {
            $0.width.equalTo(136)
        }
        
        secondDropdownView.snp.makeConstraints {
            $0.width.equalTo(92)
        }
        
        thirdDropdownView.snp.makeConstraints {
            $0.width.equalTo(92)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
