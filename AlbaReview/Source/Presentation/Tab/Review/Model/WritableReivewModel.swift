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
    var lattitude: Double
    var longtitude: Double
}

extension WritableReviewData {
    static let list = [
        WritableReviewData(name: "하삼동커피 구로구청점", reviewCount: 1, rating: 1.2, lattitude: 37.496452036314274, longtitude: 126.890285657784),
        WritableReviewData(name: "파리바게트 파주점", reviewCount: 2, rating: 2.2, lattitude: 37.4953727324904, longtitude: 126.88751954036113),
        WritableReviewData(name: "베스킨라빈스 파주점", reviewCount: 3, rating: 3.2, lattitude: 37.49456322630769, longtitude: 126.88899929327977),
        WritableReviewData(name: "버거킹 구로구청점", reviewCount: 4, rating: 4.2, lattitude: 37.49482203662735, longtitude: 126.88875578446043),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 5, rating: 4.7, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 7, rating: 1.0, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 0, rating: 4.1, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 4, rating: 2.4, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 2, rating: 3.4, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 7, rating: 2.9, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 6, rating: 0.2, lattitude: 37.49664360080225, longtitude: 126.88799258920564),
        WritableReviewData(name: "컴포즈커피 오목교점", reviewCount: 10, rating: 1.2, lattitude: 37.49664360080225, longtitude: 126.88799258920564)
    ]
}
