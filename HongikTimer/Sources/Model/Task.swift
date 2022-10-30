//
//  Task.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/28.
//

import Foundation

struct Task {
    let taskId: Int
    let userId: Int
    var contents: String?
    var isChecked: Bool?
    
    init() {
        self.taskId = 0
        self.userId = 0
    }
    
    init(
        taskId: Int,
        userId: Int,
        contents: String,
        isChecked: Bool
    ) {
        self.taskId = taskId
        self.userId = userId
        self.contents = contents
        self.isChecked = isChecked
    }
}
