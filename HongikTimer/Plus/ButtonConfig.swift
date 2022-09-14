//
//  ButtonConfig.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import UIKit

enum Config {
    case white
    case label

    var config: UIButton.Configuration {
        var filledConfig = UIButton.Configuration.filled()
        
        switch self {
        case .white:
            filledConfig.cornerStyle = .capsule
            filledConfig.baseBackgroundColor = .white
            return filledConfig
        case .label:
            filledConfig.cornerStyle = .capsule
            filledConfig.baseBackgroundColor = .label
            return filledConfig
        }
    }
}

struct ButtonConfig {
    private let buttonConfig: Config
    
    init(buttonConfig: Config) {
        self.buttonConfig = buttonConfig
    }
    
    func getConfig() -> UIButton.Configuration {
        return buttonConfig.config
    }
}
