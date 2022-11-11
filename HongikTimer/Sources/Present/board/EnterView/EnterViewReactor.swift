//
//  EnterViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/11.
//

import ReactorKit
import RxCocoa
import RxSwift

final class EnterViewReactor: Reactor {
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    let boardPost: BoardPost
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State
  
  init(
    _ provider: ServiceProviderType,
    user: User,
    boardPost: BoardPost
  ) {
    self.provider = provider
    self.user = user
    self.initialState = State(boardPost: boardPost)
  }
  
//  func mutate(action: Action) -> Observable<Mutation> {
//    <#code#>
//  }
//
//  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//    <#code#>
//  }
}
