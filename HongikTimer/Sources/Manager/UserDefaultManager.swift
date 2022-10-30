//
//  UserDefaultManager.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import Foundation

struct UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    enum Keys: String {
        case user
        
        var key: String {
            self.rawValue
        }
    }
    
    func getUser() -> User {
        guard let data = UserDefaults.standard.data(forKey: Keys.user.key) else {
            return User()
        }
        
        return (
            try? PropertyListDecoder().decode(User.self, from: data)
        ) ?? User()
    }
    
    func setUser(_ user: User) {
        let currentUser = user
        
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentUser)
            , forKey: Keys.user.key)
    }
}
