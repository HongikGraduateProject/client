//
//  EmailSignUpReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/09.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

final class EmailSignUpReactor: Reactor {
  
  let provider: ServiceProviderType
  
  enum Action {
    case emailInput(_ email: String)
    case nicknameInput(_ nickname: String)
    case passwordInput(String)
    case passwordCheckInput(String)
  }
  
  enum Mutation {
    case validateEmail(String)
    case validateNickname(String)
    case validatePassword(String)
    case validatePasswordCheck(String)
  }
  
  struct State {
    var emailMessage: NSAttributedString?
    var nickNameMessage: NSAttributedString?
    var passwordMessage: NSAttributedString?
    var passwordCheckMessage: NSAttributedString?
    var password: String?
    var passwordcheck: String?
  }
    
  var initialState: State = State()
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .emailInput(input):
      return Observable.just(Mutation.validateEmail(input))
    case let .nicknameInput(input):
      return Observable.just(Mutation.validateNickname(input))
    case let .passwordInput(input):
      return Observable.concat([
        Observable.just(Mutation.validatePassword(input)),
        Observable.just(Mutation.validatePasswordCheck(currentState.passwordcheck ?? ""))
      ])
    case let .passwordCheckInput(input):
      return Observable.just(Mutation.validatePasswordCheck(input))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
      
    case let .validateEmail(input):
      state.emailMessage = self.isValidEmail(input: input)
      return state
      
    case let .validateNickname(input):
      state.nickNameMessage = self.isValidNickname(input: input)
      return state
      
    case let .validatePassword(input):
      state.passwordMessage = self.isValidPassword(input: input)
      state.password = input
      return state
      
    case let .validatePasswordCheck(input):
      state.passwordCheckMessage = isValidPasswordCheck(input: input, pwd: state.password ?? "")
      state.passwordcheck = input
      return state
    }
  }
}

// MARK: - Method

/// email ????????? ???????????? message ??????
private extension EmailSignUpReactor {
  func isValidEmail(input: String) -> NSAttributedString {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    var message: NSAttributedString
    
    if input.isEmpty {
      message = NSAttributedString(string: "")
    } else if emailTest.evaluate(with: input) == false {
      message = NSAttributedString(
        string: "eamil ???????????? ??????????????????",
        attributes: [.foregroundColor: UIColor.systemRed]
      )
    } else {
      message = NSAttributedString(
        string: "??????????????? email ?????????.",
        attributes: [.foregroundColor: UIColor.systemGray]
      )
    }
    return message
  }
  
  func isValidNickname(input: String) -> NSAttributedString {
    let nicknameRegEx = "[???-???A-Za-z0-9]{2,8}"
    let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
    var message: NSAttributedString
    
    if input.count == 0 {
      message = NSAttributedString(string: "")
    } else if input.count == 1 {
      message = NSAttributedString(
        string: "2??? ?????? ????????? ???????????? ??????????????????.",
        attributes: [.foregroundColor: UIColor.systemRed]
      )
    } else if nicknameTest.evaluate(with: input) == false {
      message = NSAttributedString(
        string: "8??? ?????? ????????? ???????????? ??????????????????.",
        attributes: [.foregroundColor: UIColor.systemRed]
      )
    } else {
      message = NSAttributedString(
        string: "??????????????? ?????? ?????????.",
        attributes: [.foregroundColor: UIColor.systemGray]
      )
    }
    return message
  }
  
  func isValidPassword(input: String) -> NSAttributedString {
    var message: NSAttributedString?
    if input.count == 0 {
      message = NSAttributedString(string: "")
    } else if input.count > 0 && input.count < 6 {
      message = NSAttributedString(
        string: "6?????? ?????? ??????????????????",
        attributes: [.foregroundColor: UIColor.systemRed]
      )
    } else if input.count >= 6 {
      message = NSAttributedString(
        string: "??????????????? ?????????????????????.",
        attributes: [.foregroundColor: UIColor.systemGray]
      )
    }
    return message ?? NSAttributedString(string: "")
  }
  
  func isValidPasswordCheck(input: String, pwd: String) -> NSAttributedString {
    var message: NSAttributedString?
    
    if input.count == 0 {
      message = NSAttributedString(string: "")
    } else if input != pwd {
      message = NSAttributedString(
        string: "??????????????? ???????????? ????????????.",
        attributes: [.foregroundColor: UIColor.systemRed]
      )
    } else {
      message = NSAttributedString(
        string: "??????????????? ???????????????.",
        attributes: [.foregroundColor: UIColor.systemGray]
      )
    }
    return message ?? NSAttributedString(string: "")
  }
}
