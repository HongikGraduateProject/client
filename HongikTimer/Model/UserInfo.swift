//
//  UserInfo.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation

struct UserInfo: Codable {
    var email: String
    var username: String
    var password: String
    
    private enum CodingKeys: String, CodingKey {
        case email
        case username
        case password
    }
}
