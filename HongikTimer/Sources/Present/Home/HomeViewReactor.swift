//
//  HomeViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/01.
//

import ReactorKit
import RxCocoa
import RxSwift

final class HomeViewReactor: Reactor, BaseReactorType {

  let user: User
  let provider: ServiceProviderType
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let initialState: State = State()
  
  init(_ provider: ServiceProviderType, with user: User) {
    self.user = user
    self.provider = provider
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    return .empty()
  }
}
