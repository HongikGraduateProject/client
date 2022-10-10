//
//  User.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import Foundation

struct User: Codable {
    let id: Int
    var username: String
    let email: String
    var password: String
    var nickName: String?
    var phoneNumber: String?
    var age: Int
    var job: String?
    var goal: String?
    var timer: String?
    var gold: Int
    var role: String?
    var creatDate: Date?
    
    init() {
        self.id = 1
        self.username = "user1"
        self.email = "user1@gmail.com"
        self.password = "qwerty@"
        self.age = 0
        self.gold = 0
    }
    
}

// TODO: username nickname 같은거 아닌지???
