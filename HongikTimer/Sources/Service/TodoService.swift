//
//  TodoService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/13.
//

import UIKit
import RxSwift

final class TodoService {
  
  let userDefaultservice = UserDefaultService.shared

  func fetchTodoService() -> Observable<[Task]> {
    
    if let savedTasks = userDefaultservice.getTasks() {
      return .just(savedTasks)
    }
    
    #warning("더미")
    let defaultTasks: [Task] = [
      Task(default: true), Task(default: true), Task(default: true)
    ]
    self.userDefaultservice.setTasks(defaultTasks)
    return .just(defaultTasks)
  }
}
