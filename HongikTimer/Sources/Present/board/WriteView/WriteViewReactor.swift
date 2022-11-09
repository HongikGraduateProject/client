//
//  WriteViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/09.
//

import ReactorKit
import RxCocoa
import RxSwift

final class WriteViewReactor: Reactor {
  
  enum Action {
    case close
  }
  
  enum Mutation {
    case dismiss
  }
  
  struct State {
    var isDismissed: Bool
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State
  
  init(_ provider: ServiceProviderType, user: User) {
    self.provider = provider
    self.user = user
    self.initialState = State(
      isDismissed: false
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .close:
      return .just(.dismiss)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .dismiss:
      state.isDismissed = true
      return state
    }
  }
}
