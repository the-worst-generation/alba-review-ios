//
//  PlaceData.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/18.
//

import Foundation


struct Place: Codable {
    let meta: Meta
    let documents: [Document]
}

struct Meta: Codable {
    let pageableCount: Int
    
    enum CodingKeys: String, CodingKey {
        case pageableCount = "pageable_count"
    }
}

struct Document: Codable {
    let placeName: String
    let roadAddressName: String
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case roadAddressName = "road_address_name"
        case x
        case y
    }
}
