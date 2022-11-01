//
//  TabBarViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import FirebaseAuth
import UIKit

final class TabBarViewController: UITabBarController {
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTabBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    handleNotAuthenticated()
  }
}

// MARK: - Private

private extension TabBarViewController {
  
  func handleNotAuthenticated() {
    // Check auth statts
    if Auth.auth().currentUser == nil {
      // SHow log in
      
      let vc = RegisterViewController(with: RegisterViewReactor(provider: ServiceProvider()))
      let nv = UINavigationController(rootViewController: vc)
      nv.modalPresentationStyle = .fullScreen
      present(nv, animated: false)
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
