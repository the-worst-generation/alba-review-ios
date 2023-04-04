//
//  WriteReviewRatingViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/04.
//

import Foundation

import RxCocoa
import RxSwift

class WriteReviewRatingViewModel {
    let didBeginEditingSubject = BehaviorSubject<Bool>(value: false)
    let reviewTextSubject = BehaviorSubject<String>(value: "")
    
    var isEnableNextButton: Observable<Bool> {
        setIsEnableNextButton()
    }
}

extension WriteReviewRatingViewModel {
    func setIsEnableNextButton() -> Observable<Bool>{
        return .combineLatest(didBeginEditingSubject,
                              reviewTextSubject) { isBegin, text in
            if isBegin && text.count > 15 {
                return true
            }
            else { return false }
        }
    }
}
