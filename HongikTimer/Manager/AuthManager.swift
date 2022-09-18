//
//  AuthManager.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase
import UIKit

final class AuthManager: NSObject {
    
    static let shared = AuthManager()
    
    func logOutWithFirebase(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
            
        } catch {
            print("DEBUG log out with firebase error is \(error)")
            completion(false)
            return
        }
    }
}

// MARK: - Email

extension AuthManager {
    
    func logInWithEmail(
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
    
//    func logInWithEmail(
//        email: String,
//        password: String,
//        completion: @escaping (Bool) -> Void
//    ) {
//        Auth.auth().signIn(
//            withEmail: email,
//            password: password) { authResult, error in
//                guard authResult != nil, error == nil else {
//                    completion(false)
//                    return
//                }
//                completion(true)
//            }
//    }
        
        func signInWithEmail(
            credentials: AuthCredentials,
            completion: ((AuthDataResult?, Error?) -> Void)?
    ) {
        let email = credentials.email
        let password = credentials.password
        
        Auth.auth().createUser(
            withEmail: email,
            password: password,
            completion: completion
        )
    }
}
