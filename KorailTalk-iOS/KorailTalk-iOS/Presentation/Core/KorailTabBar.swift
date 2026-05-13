//
//  KorailTabBar.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/13/26.
//

import UIKit

final class KorailTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        let bottomInset = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.bottom ?? 0
        
        sizeThatFits.height = 58 + bottomInset
        return sizeThatFits
    }
}
