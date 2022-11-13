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
      Task(contents: "스위프트 문법 공부"), Task(contents: "운영체제 2주차 복습"), Task(contents: "코딩테스트 공부")
    ]
    self.userDefaultservice.setTasks(defaultTasks)
    return .just(defaultTasks)
  }
}
