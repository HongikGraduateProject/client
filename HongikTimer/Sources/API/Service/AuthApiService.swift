//
//  AuthApiService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Alamofire
import Combine
import Foundation

/// 인증 관련 api 호출
enum AuthApiService {
    
    static func register(
        email: String,
        username: String,
        password: String
    ) -> AnyPublisher<UserInfo, AFError> {
        print("AuthApiService - register() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(
                email: email,
                username: username,
                password: password
            ))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { receivedValue in
                return receivedValue.userInfo
            }.eraseToAnyPublisher()
    }
}


