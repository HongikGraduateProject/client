//
//  TaskEditViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/15.
//

import ReactorKit
import RxCocoa
import RxSwift

final class TaskEditViewReactor: Reactor, BaseReactorType {
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    let task: Task
  }
  
  let user: User
  let provider: ServiceProviderType
  let initialState: State
  
  init(provider: ServiceProviderType, user: User, task: Task) {
    self.provider = provider
    self.user = user
    self.initialState = State(task: task)
  }
  
  //  func mutate(action: Action) -> Observable<Mutation> {
  //    <#code#>
  //  }
  //
  //  func reduce(state: State, mutation: Mutation) -> State {
  //    <#code#>
  //  }
}


