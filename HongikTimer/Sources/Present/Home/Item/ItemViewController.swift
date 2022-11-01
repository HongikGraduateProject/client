//
//  ItemViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import SnapKit
import Then
import UIKit
import ReactorKit

final class ItemViewController: BaseViewController {
  
  // MARK: - Property
  
  let reactor: ItemViewReactor
  
  private lazy var previewView = PreviewView()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationbar()
    configureLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    refresh()
    reloadInputViews()
  }
  
  // MARK: - Init
  
  init(_ reactor: ItemViewReactor) {
    self.reactor = reactor
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
  
// MARK: - Bind
  
extension ItemViewController: View {
  func bind(reactor: ItemViewReactor) {
    
  }
}

// MARK: - Method

private extension ItemViewController {
  func configureNavigationbar() {
    navigationItem.title = "아이템"
    navigationController?.navigationBar.topItem?.title = ""
  }
  
  func configureLayout() {
    view.backgroundColor = .systemGray6
    [
      previewView
    ].forEach { view.addSubview($0) }
    
    previewView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(32.0)
      $0.height.equalTo(320.0)
    }
  }
  
    func refresh() {
      previewView.wallImageView.image = reactor.provider.userDefaultService.getWallImage()
      previewView.chickImageView.image = reactor.provider.userDefaultService.getChickImage()
    }
}
