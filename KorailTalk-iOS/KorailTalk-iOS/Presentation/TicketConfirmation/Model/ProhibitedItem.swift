//
//  ProhibitedItem.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/14/26.
//

import UIKit

struct ProhibitedItem {
    let iconImage: UIImage
    let title: String
    let subtitle: String
    let caption: String?
}

extension ProhibitedItem {
    static func dummy() -> [ProhibitedItem] {
        return [
            ProhibitedItem(iconImage: .icBicycle, title: "자전거 등 통행에 지장을 주는 물품", subtitle: "통로를 막아 이동에 불편을 주는 물품은 휴대 시 승차 금지", caption: "*단, 자전거는 접거나 분해해 전용 가방에 넣은 경우에만 휴대 가능"),
            ProhibitedItem(iconImage: .icKnife, title: "무기•화약류 및 인화성 높은 물질", subtitle: "무기·화약류·유해화학물질 등 위험 물질 휴대 시 승차 금지", caption: "*철도 안전법 제 42조 및 제 43조에 정한 위해 물품 및 위험물"),
            ProhibitedItem(iconImage: .icFood, title: "다른 사람에게 불편을 줄 수 있는 물품", subtitle: "열차 내 소음, 악취 유발 등 다른 사람에게\n방해를 줄 수 있는 물품을 휴대하는 경우 승차 금지", caption: nil),
            ProhibitedItem(iconImage: .icX, title: "맹수•맹금류 등 동물", subtitle: "두려움과 혐오감을 줄 수 있는 동물과 함께 승차 금지", caption: "*단, 예방접종 완료된 10kg 이하 반려동물(개·고양이·새 등)은\n총 길이 100cm 이내 운반용기에 넣어 승차 가능")
        ]
    }
}
