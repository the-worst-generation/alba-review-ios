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
    let searchTextSubject = BehaviorSubject<String>(value: "")
    
    var fetchPlace: Observable<Place> {
        searchTextToParams()
    }
}

extension SearchViewModel {
    func searchTextToParams() -> Observable<Place> {
        return searchTextSubject
            .filter { $0 != ""}
            .flatMap { API.fetchSearchPlace(text: $0) }
            .asObservable()
    }
}

