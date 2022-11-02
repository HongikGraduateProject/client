//
//  UserDefaultService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import Foundation
import UIKit

struct UserDefaultService {
  
  static let shared = UserDefaultService()
  private let standard = UserDefaults.standard
  
  enum UserDefaultKeys: String {
    
    // 로그인
    case user
    
    // Home 화면
    case chickImage
    case wallImage
    case studyTime
    
    var key: String {
      self.rawValue
    }
  }
  
  // MARK: - Auth
  
  /// 로그인 or 회원가입시 현재 유저 저장
  func setUser(_ user: User) {
    standard.setValue(
      try? PropertyListEncoder().encode(user),
      forKey: UserDefaultKeys.user.key)
  }
  
  /// 현재 유저 get
  func getUser() -> User? {
    guard let data = standard.data(forKey: UserDefaultKeys.user.key) else { return nil }
    
    return (
      try? PropertyListDecoder().decode(User.self, from: data)
    ) ?? User()
  }
  
  /// 로그아웃시 저장된 유저값 삭제
  func logoutUser() {
    standard.removeObject(forKey: UserDefaultKeys.user.key)
    
    print("DEBUG User Defau유저 정보 삭제")
  }
  
  // MARK: - Home 화면 관련
  
  // chick image
  func setChickImage(_ imageName: String) {
    standard.set(imageName, forKey: UserDefaultKeys.chickImage.key)
  }
  
  func getChickImage() -> UIImage? {
    guard let name = standard.string(forKey: UserDefaultKeys.chickImage.key) else {
      return UIImage(named: "chick0")
    }
    
    return UIImage(named: name)
  }

  // wallpaper image
  func setWallImage(_ imageName: String) {
    standard.set(imageName, forKey: UserDefaultKeys.wallImage.key)
  }
  
  func getWallImage() -> UIImage? {
    guard let name = standard.string(forKey: UserDefaultKeys.wallImage.key) else {
      return UIImage(named: "w0")
    }
    
    return UIImage(named: name)
  }
  
  // 타이머
  func setStudyTime(_ time: Int) {
    var currentitme = self.getStudyTime()
    
    print("DEBUG currenttime: \(currentitme)")
    
    currentitme += time
    
    print("DEBUG currenttime: \(currentitme)")
    
    standard.set(currentitme, forKey: UserDefaultKeys.studyTime.key)
  }
  
  func getStudyTime() -> Int {
    let time = standard.integer(forKey: UserDefaultKeys.studyTime.key)
    
    return time
  }
}
