//
//  AuthRouter.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation
import Alamofire
import SwiftUI

/// 인증 라우터
/// 회원가입, 로그인
enum AuthRouter: URLRequestConvertible {
    case register(email: String, username: String, password: String)
    case login(email: String, password: String)
//    case tokenRefresh
    
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "members"
        case .login:
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(email, password):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            return params
         
        case let .register(id, username, email):
            var params = Parameters()
            params["id"] = id
            params["username"] = username
            params["email"] = email
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
    }
}
