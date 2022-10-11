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
    
    /// 텍스트 필드가 빈 상태가 아닐때
    func configureNotEmptyTextField(_ vm: TaskViewModel) {
        taskViewModels.remove(at: taskViewModels.endIndex - 1)
        addTaskViewModel(vm)
    }
    
    /// 마지막 TaskViewModel 제거
    func removeEndIndex() {
        taskViewModels
            .remove(at: taskViewModels
            .index(before: taskViewModels.endIndex))
    }
    
    func configureEdit(
        _ taskViewModel: TaskViewModel,
        indexPath: IndexPath
    ) {
        taskViewModels[indexPath.item] = taskViewModel
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
    var task: Task
    
    init(task: Task) {
        self.contents = task.contents ?? ""
        self.isChecked = task.isChecked ?? false
        self.task = task
    }
}
