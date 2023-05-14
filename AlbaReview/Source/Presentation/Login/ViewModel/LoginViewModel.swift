//
//  LoginViewModel.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/05/14.
//

import Foundation

import RxCocoa
import RxSwift
import GoogleSignIn

class LoginViewModel {
    
}

extension LoginViewModel {
    
    func googleLogin(vc: LoginViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
            guard error == nil, let result = result else {
                print(error)
                return }
            
            let token = result.user.accessToken.tokenString
            print(token)
        }
    }
}
