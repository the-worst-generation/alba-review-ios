//
//  WritableReviewData.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/01.
//

import Foundation

struct WritableReviewData {
    var name: String
    var grade: Double
    var reviewCount: Int
}

extension WritableReviewData {
    static let list = [
        WritableReviewData(name: "컴포즈커피 오목교점", grade: 0.1, reviewCount: 0),
        WritableReviewData(name: "베스킨라빈스 파주점", grade: 1, reviewCount: 1),
        WritableReviewData(name: "하삼동커피 구로구청점", grade: 4.7, reviewCount: 123),
        WritableReviewData(name: "컴포즈커피 오목교점", grade: 0.1, reviewCount: 0),
        WritableReviewData(name: "컴포즈커피 오목교점", grade: 0.1, reviewCount: 0),
        WritableReviewData(name: "컴포즈커피 오목교점", grade: 0.1, reviewCount: 0)
    ]
}
