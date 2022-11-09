//
//  WriteViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/09.
//

import UIKit
import ReactorKit

final class WriteViewController: BaseViewController, View {
  
  typealias Reactor = WriteViewReactor
  
  // MARK: - UI
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .defaultTintColor
  }
  
  // MARK: - Initialize
  init(_ reactor: WriteViewReactor) {
    super.init()
    
    self.reactor = reactor
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Binding
  
  func bind(reactor: WriteViewReactor) {
    
  }
  
}

// MARK: - Method
