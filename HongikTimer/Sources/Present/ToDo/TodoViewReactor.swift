//
//  TodoViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/13.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxDataSources

typealias TaskListSection = SectionModel<Void, TaskCellReactor>

final class TodoViewReactor: Reactor, BaseReactorType {
  
  enum Action {
    case refresh
  }
  
  enum Mutation {
    case setSections([TaskListSection])
  }
  
  struct State {
    var sections: [TaskListSection]
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State
  
  // MARK: - Initialize
  
  init(_ provider: ServiceProviderType, user: User) {
    self.user = user
    self.provider = provider
    self.initialState = State(sections: [])
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .refresh:
      return self.provider.todoService.fetchTodoService()
        .map { tasks in
          let sectionItems = tasks.map { TaskCellReactor(self.provider, user: self.user, task: $0) }
          let section = TaskListSection(model: Void(), items: sectionItems)
          return .setSections([section])
        }
      
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case let .setSections(sections):
      state.sections = sections
    }
    
    return state
  }
}

// MARK: - Method
