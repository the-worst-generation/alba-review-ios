//
//  MyPageViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/17.
//

import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel {
    let sectionsSubject = BehaviorSubject<[MyPageSection]>(value: [])
    let headers = [
        "내 정보",
        "알바",
        "기타"
    ]
}

extension MyPageViewModel {
    func setUpSections() {
        var sections = [MyPageSection]()
        
        
        
        let accounts = [
            "닉네임 변경",
            "개인 정보 변경"
        ]
        
        let albas = [
            "알바 경력 수정",
            "작성한 리뷰",
            "스크랩한 지점"
        ]
        
        let others = [
            "앱 버전",
            "서비스 이용약관",
            "오픈소스 라이선스",
            "로그아웃",
            "회원 탈퇴"
        ]
        
        
        let profile = Profile(nickname: "알바왕", sexAndAge: "남 / 23세")
        let profileItem = MyPageSectionItem.profile(profile)
        let profileSection = MyPageSection.profile(profileItem)
        
        let accountItem = accounts.map { MyPageSectionItem.accountCell($0) }
        let accountSection = MyPageSection.account(accountItem)
        
        let albaItem = albas.map { MyPageSectionItem.albaCell($0) }
        
        let albaSection = MyPageSection.alba(albaItem)
        
        let otherItem = others.map { MyPageSectionItem.otherCell($0) }
        let otherSection = MyPageSection.other(otherItem)
         
        sections = [profileSection, accountSection, albaSection, otherSection]
        sectionsSubject.onNext(sections)
    }
}
