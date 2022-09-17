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
    
    @Published var isLoggedIn: Bool = false
    
    lazy var loginStatusInfo: AnyPublisher<String?, Never> =
    $isLoggedIn.compactMap { $0 ? "로그인 상태": "로그아웃 상태"}.eraseToAnyPublisher()
    
    func kakalLoginWithApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    
                    // do something
                    _ = oauthToken
                }
            }
        }
    }
    
    @MainActor
    func kakaoLogin() {
        Task {
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡 앱으로 로그인 인증
                isLoggedIn = await kakalLoginWithApp()
            } else { // 카톡이 설치 안됨
                // 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithAccount()
            }
        }
    }
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handlekakaoLogout() {
                self.isLoggedIn = false
            }
        }
    }
    
    func handlekakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                } else {
                    print("logout() success.")
                }
            }
        }
    }
}
