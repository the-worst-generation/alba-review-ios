//
//  AlbaExperienceViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/22.
//

import Foundation

import RxSwift

class AlbaExperienceViewModel {
    
    let albaPeriodSubject = BehaviorSubject<[String]>(value: [
        "1주일 이하",
        "1주일 ~ 1개월",
        "1개월 ~ 3개월",
        "3개월 ~ 6개월",
        "6개월 ~ 1년"
    ])
    
    let isPalceSelected = BehaviorSubject<Bool>(value: false)
    let isPeriodSelected = BehaviorSubject<Bool>(value: false)
    
    var isAbleToAdd: Observable<Bool> {
        setIsAbleToAdd()
    }
}

extension AlbaExperienceViewModel {
    
    func setIsAbleToAdd() -> Observable<Bool> {
        return .combineLatest(isPalceSelected,
                              isPeriodSelected) { isPlace, isPeriod in
            return isPlace && isPeriod
        }
    }
}
