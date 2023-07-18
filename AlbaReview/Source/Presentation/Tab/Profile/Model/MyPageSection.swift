//
//  MyPageSection.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/17.
//

import Foundation


enum MyPageSection: Hashable {
    case profile(MyPageSectionItem)
    case account([MyPageSectionItem])
    case alba([MyPageSectionItem])
    case other([MyPageSectionItem])
}

enum MyPageSectionItem: Hashable {
    case profile(Profile)
    case accountCell(String)
    case albaCell(String)
    case otherCell(String)
}

extension MyPageSection {
    var items: [MyPageSectionItem] {
        switch self {
        case .profile(let item):
            return [item]
        case .account(let item):
            return item
        case .alba(let item):
            return item
        case .other(let item):
            return item
        }
    }
}

