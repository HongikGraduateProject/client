//
//  UserViewModel.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation
import Alamofire
import Combine

//class UserViewModel: ObservableObject {
//    
//    // MARK: - properties
//    
//    var subscription = Set<AnyCancellable>()
//    
//    @Published var loggedInUser: UserInfo? = nil
//    
//    /// 회원가입 하기
//    func register(
//        email: String,
//        username: String,
//        password: String
//    ) {
//        print("DEBUG UserViewModel: register() called")
//        AuthApiService.register(
//            email: email,
//            username: username,
//            password: password
//        ).sink { completion in
//            print("DEBUG UserVM completion: \(completion)")
//        } receiveValue: { [weak self] (receiveUser: UserInfo) in
//            self?.loggedInUser = receiveUser
//            print("DEBUG UserVM reveiveData : \(receiveUser)")
//        }.store(in: &subscription)
//    }
//}
