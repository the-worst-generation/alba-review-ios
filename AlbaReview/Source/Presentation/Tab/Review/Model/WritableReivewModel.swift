//
//  WritableReivewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/02.
//

import Foundation

struct WritableReviewData {
    var name: String
    var reviewCount: Int
    var rating: Double
}

extension WritableReviewData {
    static let list = [
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 1, rating: 1.2),
        WritableReviewData(name: "파리바게트 파주점", reviewCount: 2, rating: 2.2),
        WritableReviewData(name: "베스킨라빈스 파주점", reviewCount: 3, rating: 3.2),
        WritableReviewData(name: "버거킹 구로구청점", reviewCount: 4, rating: 4.2),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 5, rating: 4.7),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 7, rating: 1.0),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 0, rating: 4.1),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 4, rating: 2.4),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 2, rating: 3.4),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 7, rating: 2.9),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 6, rating: 0.2),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 10, rating: 1.2)
    ]
}
