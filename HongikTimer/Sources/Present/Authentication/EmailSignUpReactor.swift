//
//  EmailSignUpReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/31.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class EmailSignUpReactor: Reactor {
  
  let provider: ServiceProviderType
  
  enum Action {
    case emailInput(_ email: String)
    case nicknameInput(_ nickname: String)
    case passwordInput(String)
    case passwordCheckInput(String, String)
  }
  
  enum Mutation {
    case checkEmail(String)
    case checkNickname(String)
    case checkPassword(String)
    case checkPasswordCheck(String)
  }
 
  struct State {
    var emailMessage: NSAttributedString
    var nickNameMessage: NSAttributedString
    var passwordMessage: NSAttributedString
    var passwordCheckMessage: NSAttributedString
  }
  
  var initialState: State = State(
    emailMessage: NSAttributedString(""),
    nickNameMessage: NSAttributedString(""),
    passwordMessage: NSAttributedString(""),
    passwordCheckMessage: NSAttributedString("")
  )

  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .emailInput(input):
      return Observable.just(Mutation.checkEmail(input))
    case let .nicknameInput(input):
      return Observable.just(Mutation.checkNickname(input))
    case let .passwordInput(input):
      return Observable.just(Mutation.checkPassword(input))
    case let .passwordCheckInput(input):
      return Observable.just(Mutation.checkPasswordCheck(input))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
      
    case let .checkEmail(input):
            
      if input.isEmpty {
        let message = NSAttributedString(string: "")
        state.emailMessage = message
        
      } else if input.contains("@") == false {
        
        let message = NSAttributedString(
          string: "eamil 형식으로 입력해주세요",
          attributes: [.foregroundColor: UIColor.systemRed]
        )
        state.emailMessage = message
        
      } else {
        let message = NSAttributedString(
          string: "사용가능한 email 입니다.",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.emailMessage = message
      }
      return state
      
    case let .checkNickname(input):
      
      if input.count == 0 {
        let message = NSAttributedString(
          string: "",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.nickNameMessage = message
      } else if input.count > 9 {
        let message = NSAttributedString(
          string: "8자 이하로 입력해주세요.",
          attributes: [.foregroundColor: UIColor.systemRed]
        )
        state.nickNameMessage = message
        
      } else {
        let message = NSAttributedString(
          string: "사용가능한 별명 입니다.",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.nickNameMessage = message
      }
      return state
      
    case let .checkPassword(input):
      
      if input.count == 0 {
        let message = NSAttributedString(
          string: "",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.nickNameMessage = message
      } else if input.count < 6 {
        let message = NSAttributedString(
          string: "6자리 이상 입력해주세요",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.passwordMessage = message
      } else {
        let message = NSAttributedString(
          string: "사용가능한 비밀번호입니다.",
          attributes: [.foregroundColor: UIColor.systemGray]
        )
        state.passwordMessage = message
      }
      
      return state
      
    case let .checkPasswordCheck(input):
      return state
    
    }
  }
}
