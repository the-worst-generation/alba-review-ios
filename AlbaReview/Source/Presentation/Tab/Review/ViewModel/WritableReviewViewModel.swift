//
//  WritableReviewViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/01.
//

import Foundation

import RxCocoa
import RxSwift

class WritableReviewViewModel {
    let writableReviewListOb: Observable<[WritableReviewData]>
    
    init() {
        writableReviewListOb = .just(WritableReviewData.list)
    }
}
