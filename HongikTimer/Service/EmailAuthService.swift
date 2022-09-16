//
//  EmailAuthService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase
import UIKit

struct EmailAuthService {
    static let shared = EmailAuthService()
    
    func loginUser(
        email: String,
        password: String,
        completion: @escaping((AuthDataResult?, Error?) -> Void)
    ) {
        Auth.auth().signIn(
            withEmail: email,
            password: password,
            completion: completion
        )
    }
    
    func registerUser(
        credentials: AuthCredentials,
        completion: ((AuthDataResult?, Error?) -> Void)?
    ) {
        let email = credentials.email
//        let nickname = credentials.nickname
        let password = credentials.password
        
        Auth.auth().createUser(
            withEmail: email,
            password: password,
            completion: completion
        )
    }
}
