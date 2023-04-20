//
//  Address.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/18.
//

import Foundation

enum Address {
    case searchPlace
}

extension Address {
    var url: String {
        switch self {
        case .searchPlace:
            return "https://dapi.kakao.com/v2/local/search/keyword.json"
        }
    }
}
