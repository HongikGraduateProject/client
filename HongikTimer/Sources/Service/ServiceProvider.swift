//
//  ServiceProvider.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/31.
//

import Foundation
import NaverThirdPartyLogin

final class ServiceProvider {
  
  static let authService = AuthService()
  static let appleAuthService = AppleAuthService()
  static let googleAuthService = GoogleAuthService()
  static let kakaoAuthService = KakaoAuthService()
  static let naverAuthService = NaverThirdPartyLoginConnection.getSharedInstance()
  static let authNotificationService = AuthNotificationManager()
  static let todoNotificationService = TodoNotificationService()
  static let userDefaultService = UserDefaultService()
}
