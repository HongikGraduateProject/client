//
//  TabBarViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import FirebaseAuth
import UIKit
import SwiftUI

final class TabBarViewController: UITabBarController {
  
  // MARK: - Property
  
  let reactor: TabBarViewReactor
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTabBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    handleNotAuthenticated()    
  }
  
  // MARK: - Init
  
  init(with reactor: TabBarViewReactor) {
    self.reactor = reactor
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Method

private extension TabBarViewController {
  
  func handleNotAuthenticated() {
    
    // Check auth with firebase
//    if Auth.auth().currentUser == nil {
      // SHow log in
    
    if reactor.provider.userDefaultService.isCurrentUser() == false {
    
      let vc = RegisterViewController(with: RegisterViewReactor(provider: ServiceProvider()))
      let nv = UINavigationController(rootViewController: vc)
      nv.modalPresentationStyle = .fullScreen
      present(nv, animated: false)
    } else {
      reactor.user = reactor.provider.userDefaultService.getUser()
      guard let user = reactor.user else { return }
      print("DEBUG 현재 사용중인 유저: \(user)")
    }
  }
  
  func setTabBar() {
    let tabBarViewControllers: [UIViewController] = TabBarItem
      .allCases.map { tabCase in
        let viewController = tabCase.viewController
        viewController.tabBarItem = UITabBarItem(
          title: tabCase.title,
          image: tabCase.icon.default,
          selectedImage: tabCase.icon.selected
        )
        return viewController
      }
    viewControllers = tabBarViewControllers
    tabBar.backgroundColor = .systemGray6
  }
}
