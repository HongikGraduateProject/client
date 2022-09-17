//
//  AuthNotificationService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/17.
//

import UIKit

enum AuthentState: String {
    case signOutSuccess
    case signOutError
    case signInSuccess
    case signInError
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}

struct AuthNotificationService {
    
    static let shared = AuthNotificationService()
    
    func postNotificationSignInSuccess() {
        NotificationCenter.default.post(
            name: AuthentState.signInSuccess.notificationName,
            object: nil)
    }
    
    func postNotificationSignInError() {
        NotificationCenter.default.post(
            name: AuthentState.signInError.notificationName,
            object: nil
        )
    }
    
    func postNotificationSignOutSuccess() {
        NotificationCenter.default.post(
            name: AuthentState.signOutSuccess.notificationName,
            object: nil
        )
    }
    
    func postNotificationSignOutError() {
        NotificationCenter.default.post(
            name: AuthentState.signOutError.notificationName,
            object: nil
        )
    }
    
    func addObserverSignInSuccess(with viewController: UIViewController, completion: Selector) {
        NotificationCenter.default.addObserver(
            viewController,
            selector: completion,
            name: AuthentState.signInSuccess.notificationName,
            object: nil
        )
    }
}
