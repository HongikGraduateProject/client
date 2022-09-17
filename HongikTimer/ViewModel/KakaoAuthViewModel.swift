//
//  KakaoAuthViewModel.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/17.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoAuthViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    func handleKakaoLogin() {
        print("DEBUG KakaoAuthViewModel - handleKakaoLogin() called")
        
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        } else { // 카톡 미설치
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
}
