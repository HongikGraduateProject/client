//
//  UIColor+Extension.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import UIKit

extension UIColor {
    static let defaultTintColor = UIColor.systemGreen
    static let barTint = UIColor.label
    
    struct Social {
        static let naverGreen = UIColor(red: 3, green: 199, blue: 90)
        static let kakaoYellow = UIColor(red: 247, green: 230, blue: 0)
        static let kakaoBrown = UIColor(red: 58, green: 29, blue: 29)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
