//
//  SceneDelegate.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import KakaoSDKAuth
import NaverThirdPartyLogin
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        UINavigationBar.appearance().tintColor = .barTint
        UITabBar.appearance().tintColor = .barTint
                window?.rootViewController = TabBarViewController()
        
        window?.makeKeyAndVisible()
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            } else {
                NaverThirdPartyLoginConnection
                    .getSharedInstance()?
                    .receiveAccessToken(URLContexts.first?.url)
        
            }
            
        }
    }
}
