//
//  TabbarController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//
import UIKit

import SnapKit
import Then

final class TabbarController: UITabBarController {
    
    //MARK: - UI Components
    
    private let customBar = BaseUIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }
    
    private let homeTab = TabbarButton(
        normalImage: .icHome,
        selectedImage: .icHomeActive,
        title: "홈"
    )
    private let benefitTab = TabbarButton(
        normalImage: .icBenefit,
        selectedImage: .icBenefitActive,
        title: "혜택·정기권"
    )
    private let travelTab = TabbarButton(
        normalImage: .icTravelpass,
        selectedImage: .icTravelpassActive,
        title: "상품·패스"
    )
    private let ticketTab = TabbarButton(
        normalImage: .icMyticket,
        selectedImage: .icMyticketActive,
        title: "나의 티켓"
    )
    
    
    private lazy var customTabBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
        $0.addArrangedSubviews(homeTab,benefitTab,travelTab,ticketTab)
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        
        view.addSubview(customBar)
        
        customBar.addSubview(customTabBar)
        
        setLayout()
    }
    
    // MARK: - Private Methods
    
    private func setLayout() {
        customBar.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(91)
        }
        
        customTabBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
