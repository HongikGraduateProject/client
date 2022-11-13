//
//  TaskCellReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/13.
//

import ReactorKit
import RxCocoa
import RxSwift

final class TaskCellReactor: Reactor, BaseReactorType {
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    var task: Task
    var isEnabled: Bool
  }
  
  let user: User
  let provider: ServiceProviderType
  let initialState: State
  
  init(_ provider: ServiceProviderType, user: User, task: Task, isEnabled: Bool = false) {
    self.user = user
    self.provider = provider
    self.initialState = State(task: task, isEnabled: isEnabled)
  }
  
  //  func mutate(action: Action) -> Observable<Mutation> {
  //    <#code#>
  //  }
  //
  //  func reduce(state: State, mutation: Mutation) -> State {
  //    <#code#>
  //  }
}
