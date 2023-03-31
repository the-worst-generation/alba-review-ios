//
//  SearchViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/30.
//

import Foundation

import RxCocoa
import RxSwift

class SearchViewModel {
    let disposeBag = DisposeBag()
    let searchTextOb = BehaviorSubject<String>(value: "")
}


