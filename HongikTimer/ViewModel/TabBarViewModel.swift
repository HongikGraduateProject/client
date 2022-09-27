//
//  TabBarItem.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import UIKit

enum TabBarItem: CaseIterable {
    case home
    case todo
    case timer
    case group
//    case setting
    
    var title: String {
        switch self {
        case .home: return ""
        case .todo: return  ""
        case .timer: return ""
        case .group: return ""
//        case .setting: return ""
        }
    }
    
    var icon: (
        default: UIImage?,
        selected: UIImage?
    ) {
        switch self {
        case .home:
            return (
                UIImage(systemName: "house"),
                UIImage(systemName: "house.fill")
            )
        case .todo:
            return (
                UIImage(systemName: "checklist"),
                UIImage(systemName: "checklist")
            )
        case .timer:
            return (
                UIImage(systemName: "timer"),
                UIImage(systemName: "timer")
            )
        case .group:
            return (
                UIImage(systemName: "person.3"),
                UIImage(systemName: "person.3.fill")
            )
//        case .setting:
//            return (
//                UIImage(systemName: "gearshape"),
//                UIImage(systemName: "gearshape.fill")
//            )
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return UINavigationController(rootViewController: HomeViewController())
        case .todo:
            return UINavigationController(rootViewController: ToDoViewController())
        case .timer:
            return UINavigationController(rootViewController: UIViewController())
        case .group:
            return UINavigationController(rootViewController: UIViewController())
//        case .setting:
//            return UINavigationController(rootViewController: UIViewController())
        }
    }
}
