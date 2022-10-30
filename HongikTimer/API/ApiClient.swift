//
//  ApiClient.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation
import Alamofire

/// api 호출 클라이언트
final class ApiClient {
    
    static let shared = ApiClient()
    
    static let BASE_URL = "http://localhost:8080/api"
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
                          // 기본 필수 파라미터, 기본 사용자 정보 필요시 입력
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors)
    }
}
