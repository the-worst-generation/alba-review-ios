//
//  ServiceApi.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/30.
//

import UIKit

import Alamofire
import RxAlamofire
import RxCodable
import RxSwift

enum NetworkError: Error {
    case invalidParameters
    case invalidURL
    case invalidResponse
    case decodingError
    case incodingError
    case unknownError
}

fileprivate func networking<T: Decodable>(
    urlStr: String,
    method: HTTPMethod,
    headers: HTTPHeaders,
    data: Data?,
    params: [String: Any]?,
    model: T.Type) -> Observable<T> {
        
        var urlQuery: String
        
        if let query = params {
            let queryString = query.map { "\($0.key)=\($0.value)"}.joined(separator: "&")
            urlQuery =  urlStr + "?\(queryString)"
        } else {
            urlQuery = urlStr
        }
        
        guard let encodedStr = urlQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return Observable.error(NetworkError.incodingError) }
        let url = URL(string: encodedStr)!
        
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = data
        request.headers = headers
        
        
        return RxAlamofire.requestData(request)
            .map { $0.1 }
            .flatMap {
                do {
                    let decodingModel = try JSONDecoder().decode(model.self, from: $0)
                    return Observable.just(decodingModel)
                } catch {
                    return Observable.error(error)
                }
            }
            .asObservable()
}

final class API {
    static func fetchSearchPlace(text: String) -> Observable<Place> {
        
        let params = ["query": text]
        
        return networking(
            urlStr: Address.searchPlace.url,
            method: .get,
            headers: ["Authorization": Bundle.main.KAKAO_SEARCH_API_KEY],
            data: nil,
            params: params,
            model: Place.self
        ).catchError { err in
            return Observable.error(err)
        }
    }
}
