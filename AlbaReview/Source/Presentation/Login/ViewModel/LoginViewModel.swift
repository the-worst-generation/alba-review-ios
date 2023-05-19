//
//  LoginViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/05/14.
//

import Foundation


import RxSwift
import GoogleSignIn

import RxKakaoSDKAuth
import KakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKUser

class LoginViewModel {
    let disposeBag = DisposeBag()
    
    
    let kakaoLoginSubject = BehaviorSubject<OAuthToken?>(value: nil)
}

extension LoginViewModel {
    
    func googleLogin(vc: LoginViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
            guard error == nil, let result = result else { return }
            
            let token = result.user.accessToken.tokenString
            print(token)
        }
    }
    
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .bind(to:kakaoLoginSubject)
                .disposed(by: disposeBag)
        }
    }
    
}
