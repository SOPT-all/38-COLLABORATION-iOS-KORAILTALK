//
//  KorailTabBarController.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/10/26.
//

import UIKit

final class KorailTabBarController: UITabBarController {
    
    // MARK: - Property
    
    private let backgroundView = UIView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        setValue(KorailTabBar(), forKey: "tabBar")
        setTabBar()
        setAppearance()
        setBackgroundView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundView.frame = tabBar.bounds
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 20
        
        tabBar.items?.forEach { item in
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
    }
    
    // MARK: - Private Methods
    
    private func setTabBar() {
        let controllers = KorailTab.allCases.map { tab -> UINavigationController in
            let rootViewController = tab.viewController
            let navigationViewController = UINavigationController(rootViewController: rootViewController ?? TrainSearchViewController())
            
            navigationViewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image.withRenderingMode(.alwaysOriginal),
                selectedImage: (tab.selectedImage ?? tab.image).withRenderingMode(.alwaysOriginal)
            )
            
            return navigationViewController
        }
        
        self.viewControllers = controllers
    }
    
    private func setAppearance() {
        let barAppearance = UITabBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = .surfaceDefault
        barAppearance.shadowColor = nil
        barAppearance.shadowImage = nil
        
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.titleTextAttributes = [.font: UIFont.pretendard(.body2), .foregroundColor: UIColor.neutral900]
        itemAppearance.selected.titleTextAttributes = [.font: UIFont.pretendard(.body2), .foregroundColor: UIColor.neutral900]
        
        let titleOffset = UIOffset(horizontal: 0, vertical: 12)
        itemAppearance.normal.titlePositionAdjustment = titleOffset
        itemAppearance.selected.titlePositionAdjustment = titleOffset
        
        barAppearance.stackedLayoutAppearance = itemAppearance
        barAppearance.inlineLayoutAppearance = itemAppearance
        barAppearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = barAppearance
        tabBar.scrollEdgeAppearance = barAppearance
    }
    
    private func setBackgroundView() {
        backgroundView.backgroundColor = .surfaceDefault
        
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        backgroundView.layer.shadowColor = UIColor.primary100.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: -4)
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.masksToBounds = false
        
        tabBar.insertSubview(backgroundView, at: 0)
    }
}

extension KorailTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else { return true }
        
        let selectedTab = KorailTab(rawValue: index)
        
        if selectedTab == .travel || selectedTab == .benefit {
            return false
        }
        
        return true
    }
}
