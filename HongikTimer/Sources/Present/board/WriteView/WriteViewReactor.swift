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
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State = State()
  
  init(_ provider: ServiceProviderType, user: User) {
    self.provider = provider
    self.user = user
  }
  
}
