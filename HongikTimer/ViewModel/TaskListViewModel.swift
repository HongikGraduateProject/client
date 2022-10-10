//
//  TaskListViewModel.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/09.
//

import Foundation

class TaskListViewModel {
    
    private var taskViewModels: [TaskViewModel] = [
        TaskViewModel(task: Task(
            taskId: 0,
            userId: 0,
            contents: "독서",
            isChecked: true)),
        TaskViewModel(task: Task(
            taskId: 0,
            userId: 0,
            
            contents: "운동",
            isChecked: false))
    ]
    
    func addTaskViewModel(_ vm: TaskViewModel) {
        taskViewModels.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return taskViewModels.count
    }
    
    func modelAt(_ index: Int) -> TaskViewModel {
        return taskViewModels[index]
    }
    
}

class TaskViewModel {
    var contents: String
    var isChecked: Bool
    
    init(task: Task) {
        self.contents = task.contents
        self.isChecked = task.isChecked
    }
}
