//
//  KakaoAuthService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/17.
//

import KakaoSDKAuth
import KakaoSDKUser
import UIKit

struct KakaoAuthService {
    
    static let shared = KakaoAuthService()
    
    func signInWithKakao() {
        
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    
                    // do something
                    _ = oauthToken
                    AuthNotificationService
                        .shared
                        .postNotificationSignInSuccess()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    AuthNotificationService
                        .shared
                        .postNotificationSignInSuccess()
                    // do something
                    _ = oauthToken
                }
            }
        }
    }
    func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            } else {
                print("logout() success.")
                AuthNotificationService
                    .shared
                    .postNotificationSignOutSuccess()
            }
        }
    }
}
