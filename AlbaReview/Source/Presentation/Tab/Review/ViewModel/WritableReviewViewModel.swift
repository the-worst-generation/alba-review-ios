//
//  WritableReviewViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/02.
//

import Foundation

import RxSwift
import RxCocoa

class WritableReviewViewModel {
    
    let writableReviewListSubject = BehaviorSubject<[WritableReviewSection]>(value: [WritableReviewSection(items: WritableReviewData.list)])
}
