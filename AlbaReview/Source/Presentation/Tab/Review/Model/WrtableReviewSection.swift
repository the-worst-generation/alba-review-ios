//
//  WrtableReviewSection.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/01.
//

import Foundation

import RxDataSources

struct WritableReviewSection {
    var items: [Item]
    
    init(items: [WritableReviewData]) {
        self.items = items
    }
}

extension WritableReviewSection: SectionModelType {
    
    typealias Item = WritableReviewData
    init(original: WritableReviewSection, items: [Item]) {
        self = original
        self.items = items
    }
}
