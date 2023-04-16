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
    static let shared = WritableReviewViewModel()
    
    let writableReviewListSubject = BehaviorSubject<[WritableReviewSection]>(value: [WritableReviewSection(items: WritableReviewData.list)])
    let selectedModelSubject = BehaviorSubject<WritableReviewData?>(value: nil)
    let didTapWriteReviewEnd = BehaviorSubject<Bool>(value: false)
    
    var isSelectedItem: Observable<Bool> {
        setIsSelectedItem()
    }
    
    var writedReview: Observable<WritableReviewData?> {
        setWritedReview()
    }
    
    
    private init () { }
    
}

extension WritableReviewViewModel {
    
    func setIsSelectedItem() -> Observable<Bool> {
        selectedModelSubject
            .map {
                if $0 != nil { return true }
                else { return false }
            }
    }
    
    func setWritedReview() -> Observable<WritableReviewData?> {
        return .combineLatest(selectedModelSubject,
                              didTapWriteReviewEnd) { item, isTapEnd in
            print(isTapEnd)
            print (item)
            if isTapEnd {
                return item
            } else { return nil }
        }
    }
}
