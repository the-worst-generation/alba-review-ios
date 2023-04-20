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
    
    static let shared = SearchViewModel()
    
    let disposeBag = DisposeBag()
    let searchTextSubject = BehaviorSubject<String>(value: "")
    let searchPlaceList = BehaviorSubject<[Document]>(value: [])
    let selectedPlaceSubject = BehaviorSubject<Document>(value: Document(placeName: "", addressName: "", x: "0", y: "0"))
    
    var placeList: Observable<Place> {
        searchTextToParams()
    }
    
    
    private init() { }
}

extension SearchViewModel {
    func searchTextToParams() -> Observable<Place> {
        return searchTextSubject
            .filter { $0 != ""}
            .flatMapLatest { API.fetchSearchPlace(text: $0) }
    }
}


