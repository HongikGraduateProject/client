//
//  TabBarViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/01.
//

import UIKit

final class TabBarViewReactor {
   
  let provider: ServiceProviderType
  var user: User?
  
  init(_ provider: ServiceProviderType, with user: User? = nil) {
    self.provider = provider
    self.user = user
  }
}
