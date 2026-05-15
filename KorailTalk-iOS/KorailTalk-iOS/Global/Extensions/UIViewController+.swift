//
//  UIViewController+.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

extension UIViewController {
    var statusBarHeight: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
