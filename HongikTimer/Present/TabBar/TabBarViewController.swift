//
//  TabBarViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

private extension TabBarViewController {
    
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
        tabBar.tintColor = .label
    }
}
