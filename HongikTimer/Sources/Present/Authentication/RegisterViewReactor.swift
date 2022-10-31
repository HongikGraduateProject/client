//
//  RegisterViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/31.
//

import UIKit
import ReactorKit

final class RegisterViewReactor: Reactor {
  
  let provider: ServiceProviderType
  
  enum Action {
    
  }
 
  enum State {
    case none
  }
  
  var initialState: State = State.none

  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
}
