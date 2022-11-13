//
//  TaskHeaderCellReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/12.
//

import ReactorKit
import RxCocoa
import RxSwift

final class TaskHeaderCellReactor: Reactor, BaseReactorType {
  
  enum Action {
    case plusTask
  }
  
  enum Mutation {
    case plusTask
  }
  
  struct State {
    
  }
  
  // MARK: - Property
  
  let provider: ServiceProviderType
  let user: User
  let initialState = State()
  
  // MARK: - Init
  
  init(_ provider: ServiceProviderType, user: User) {
    self.provider = provider
    self.user = user
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    var newMutate: Observable<Mutation>
    switch action {
    case .plusTask:
      newMutate = .just(.plusTask)
    }
    return newMutate
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .plusTask:
      print("tapppppppp")
    }
    return state
  }
}
