//
//  수정TabBarController.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/12/26.
//

//
//  WatchaTabBarController.swift
//  Watcha-Clone
//
//  Created by mandoo on 4/29/26.
//

import UIKit

enum KorailTab: Int, CaseIterable {
    case home = 0
    case benefit
    case travel
    case myticket
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .benefit:
            return "혜택·정기권"
        case .travel:
            return "상품·패스"
        case .myticket:
            return "나의 티켓"
        }
    }
    
    var image: UIImage {
        switch self {
        case .home:
            return .icHome
        case .benefit:
            return .icBenefit
        case .travel:
            return .icTravelpass
        case .myticket:
            return .icMyticket
        }
    }
    
    var selectedImage: UIImage{
        switch self{
        case .home:
            return .icHomeActive
        case .benefit:
            return .icBenefitActive
        case .travel:
            return .icTravelpassActive
        case .myticket:
            return .icMyticketActive
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return TrainSearchViewController()
        case .myticket:
            return MyTicketViewController()
        case .benefit, .travel:
            return EmptyViewController()
        }
    }
}

final class RealTabbarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabbar(), forKey: "tabBar")
        
        setTabBar()
        setAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 91
        tabBarFrame.origin.y = view.frame.size.height - 99
        tabBar.frame = tabBarFrame
    }
    
    // MARK: - Private Methods
    
    private func setTabBar() {
        let controllers = KorailTab.allCases.map { tab -> UINavigationController in
            let rootViewController = tab.viewController
            let navigationViewController = UINavigationController(rootViewController: rootViewController)
            
            //let icon = (tab == .home) ? tab.image.withRenderingMode(.alwaysTemplate) : tab.image
            
            navigationViewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image,
                selectedImage: tab.selectedImage
            )
            
            return navigationViewController
        }
        
        self.viewControllers = controllers
    }
    
    private func setAppearance() {
        let barAppearance = UITabBarAppearance()
        
        barAppearance.configureWithDefaultBackground()
        barAppearance.backgroundEffect = nil
        barAppearance.shadowImage = nil
        barAppearance.shadowColor = .clear
        barAppearance.backgroundColor = .white
        
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.iconColor = .white
        
        itemAppearance.normal.titleTextAttributes = [.font: UIFont.pretendard(.caption1), .foregroundColor: UIColor.black]
        itemAppearance.selected.titleTextAttributes = [.font: UIFont.pretendard(.caption1), .foregroundColor: UIColor.black]
        
        let offset = UIOffset(horizontal: 0, vertical: 5)
        itemAppearance.normal.titlePositionAdjustment = offset
        itemAppearance.selected.titlePositionAdjustment = offset
        
        barAppearance.stackedLayoutAppearance = itemAppearance
        barAppearance.inlineLayoutAppearance = itemAppearance
        barAppearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = barAppearance
        tabBar.scrollEdgeAppearance = barAppearance
        tabBar.layer.cornerRadius = 0
    }
}

final class CustomTabbar: UITabBar{
    override func layoutSubviews(){
        super.layoutSubviews()
        
        setStyle()
    }
    private func setStyle(){
        backgroundColor = .white
        layer.cornerRadius = 0
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.neutral300.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
    }
}
