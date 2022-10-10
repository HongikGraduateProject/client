//
//  AuthManager.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase
import UIKit
import Alamofire

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
    
    func sign(username: String, email: String, password: String) {
        let param: Parameters = [
            "username": username,
            "email": email,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(URLS.loginURL, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
        
        
//        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseString() { response in
//            switch response.result {
//            case .failure(let e):
//                //에러메세지 출력
//                print(e)
//            case .success:
//                //회원가입 후 로직 작성
//            }
//        }
        
    }
    
    
}
