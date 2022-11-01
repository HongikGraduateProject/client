//
//  UserDefaultService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import Foundation

struct UserDefaultService {
  
  static let shared = UserDefaultService()
  private let standard = UserDefaults.standard
  
  enum UserDefaultKeys: String {
    case user
    
    var key: String {
      self.rawValue
    }
  }
  
  /// 현재 유저 존재하는지 확인
//  func isCurrentUser() -> Bool {
//    if standard.data(forKey: UserDefaultKeys.user.key) == nil {
//      return false
//    } else {
//      return true
//    }
//  }
  
  /// 현재 유저 get
  func getUser() -> User? {
    guard let data = standard.data(forKey: UserDefaultKeys.user.key) else { return nil }
    
    return (
      try? PropertyListDecoder().decode(User.self, from: data)
    ) ?? User()
  }
  
  /// 로그인 or 회원가입시 현재 유저 저장
  func setUser(_ user: User) {
    let currentUser = user
    
    standard.setValue(
      try? PropertyListEncoder().encode(currentUser)
      , forKey: UserDefaultKeys.user.key)
  }
  
  /// 로그아웃시 저장된 유저값 삭제
  func logoutUser() {
    standard.removeObject(forKey: UserDefaultKeys.user.key)
    
    print("DEBUG User Defau유저 정보 삭제")
  }
}
