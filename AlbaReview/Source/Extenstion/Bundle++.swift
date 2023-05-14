//
//  Bundle++.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/18.
//

import Foundation

extension Bundle {
    var KAKAO_SEARCH_API_KEY: String {
        guard let file = self.path(forResource: "API_KEY", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["KAKAO_SEARCH_API_KEY"] as? String else {
            fatalError("API_KEY error")
        }
        return key
    }
    
    var GOOGLE_CLIENT_ID: String {
        guard let file = self.path(forResource: "API_KEY", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["GOOGLE_CLIENT_ID"] as? String else {
            fatalError("API_KEY error")
        }
        return key
    }
}
