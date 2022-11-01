//
//  AuthManager.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase
import UIKit
import Alamofire

final class AuthService: NSObject {
  
  static let shared = AuthService()
  
  var userVM = UserViewModel()
  
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

extension AuthService {
  
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
    
    let param: Parameters = [
      "email": email,
      "password": password
    ]
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    AF.request(URLs.login.url,
               method: .post,
               parameters: param,
               encoding: JSONEncoding.default,
               headers: headers).responseString { response in
      switch response.result {
      case .failure(let error):
        print("DEBUG email 로그인 후 post error")
        print(error)
      case .success:
        // 이후에 로그인 성공 후 로직 실행
        print("DEBUG email 로그인 post 성공")
      }
    }
  }
  
  func signUpWithEmail(
    credentials: AuthCredentials,
    completion: ((AuthDataResult?, Error?) -> Void)?
  ) {
    let email = credentials.email
    let username = credentials.username
    let password = credentials.password
    
    // firebase 사용
    Auth.auth().createUser(
      withEmail: email,
      password: password,
      completion: completion
    )
    
    //    userVM.register(
    //      email: email,
    //      username: username,
    //      password: password
    //    )
    
    let parameters: Parameters = [
      "username": credentials.username,
      "email": credentials.email,
      "password": credentials.password
    ]
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    
    AF.request(
      URLs.signin.url,
      method: .post,
      parameters: parameters,
      encoding: JSONEncoding.default,
      headers: headers
    ).responseDecodable(of: User.self) { response in
      switch response.result {
      case .success(let user):
        print("DEBUG Email: \(user.email), Username: \(user.username) 으로 회원가입 성공")
        UserDefaultService.shared.setUser(user)
      case .failure(let error):
        print("DEBUG 회원가입 post 실패 error: \(error)")
      
        #warning("dummy current user")
        let user = User()
        UserDefaultService.shared.setUser(user)
      }
    }
  }
}
