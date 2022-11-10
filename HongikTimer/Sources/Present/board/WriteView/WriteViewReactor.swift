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
    case selectNumber
  }
  
  enum Mutation {
    case dismiss
    case selectNumber
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
    case .selectNumber:
      return .just(.selectNumber)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .dismiss:
      state.isDismissed = true
      return state
    case .selectNumber:
      
      print("tapppppppp")
      
      return state
    }
  }
}
