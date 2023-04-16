//
//  WriteReviewViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

class WriteReviewViewModel {
    let disposeBag = DisposeBag()
    let tagTapSubject = BehaviorSubject<Bool>(value: false)
    let countTapTagSubject = BehaviorSubject<Int>(value: 0)
    
    var isEnableNextButton: Observable<Bool> {
        setIsEnableButton()
    }
}


extension WriteReviewViewModel {
    func countTapTag() {
        tagTapSubject
            .take(1)
            .subscribe(onNext: {
                if $0 { self.countTapTagSubject.onNext(+1)}
                else { self.countTapTagSubject.onNext(-1)}
            }).disposed(by: disposeBag)
    }
    
    func setIsEnableButton() -> Observable<Bool>{
        countTapTagSubject
            .scan(0, accumulator: +)
            .map { $0 > 0}
            .asObservable()
    }
}
