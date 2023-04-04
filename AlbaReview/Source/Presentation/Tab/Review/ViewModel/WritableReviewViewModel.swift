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
    let selectedModelSubject = BehaviorSubject<WritableReviewData?>(value: nil)
    var isSelectedItem: Observable<Bool> {
        setIsSelectedItem()
    }
    
}

extension WritableReviewViewModel {
    func setIsSelectedItem() -> Observable<Bool> {
        selectedModelSubject
            .map {
                if $0 != nil { return true }
                else { return false }
            }
    }
}
