//
//  WriteViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/09.
//

import UIKit
import ReactorKit
import RxGesture

final class WriteViewController: BaseViewController, View {
  
  typealias Reactor = WriteViewReactor
  
  // MARK: - UI
  
  private lazy var closeBarButton = UIBarButtonItem().then {
    $0.image = UIImage(systemName: "xmark")?.withTintColor(.label, renderingMode: .alwaysOriginal)
  }
  
  private lazy var submitBarButton = UIBarButtonItem().then {
    $0.title = "완료"
  }
  
  private lazy var titleTextField = UITextField().then {
    $0.placeholder = "글 제목"
  }
  
  private lazy var numberSelectView = NumberSelectView()
  
  private lazy var contentTextView = UITextView().then {
    $0.font = .systemFont(ofSize: 17.0)
  }
  
  private lazy var firstSeparatorView = UIView().then {
    $0.backgroundColor = .separator
  }
  
  private lazy var secondSeparatorView = UIView().then {
    $0.backgroundColor = .separator
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    
    #warning("dummy")
    numberSelectView.numberLabel.text = "인원수 선택"
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
    
    // action
    closeBarButton.rx.tap
      .map { Reactor.Action.close }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    numberSelectView.rx.tapGesture()
      .when(.recognized)
      .asObservable()
      .map { _ in Reactor.Action.selectNumber }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // state
    reactor.state.asObservable().map { $0.isDismissed }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true)
      })
      .disposed(by: self.disposeBag)
  }
}

// MARK: - Method

extension WriteViewController {
  
  func configureLayout() {
    self.view.backgroundColor = .systemBackground
    
    self.navigationItem.title = "글쓰기"
    self.navigationItem.leftBarButtonItem = closeBarButton
    self.navigationItem.rightBarButtonItem = submitBarButton

    [
      titleTextField,
      firstSeparatorView,
      numberSelectView,
      secondSeparatorView,
      contentTextView
    ].forEach { view.addSubview($0) }
    
    titleTextField.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
    }
    
    firstSeparatorView.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(16.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.height.equalTo(0.5)
    }
    
    numberSelectView.snp.makeConstraints {
      $0.top.equalTo(firstSeparatorView.snp.bottom).offset(16.0)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(14.0)
    }
    
    secondSeparatorView.snp.makeConstraints {
      $0.top.equalTo(numberSelectView.snp.bottom).offset(16.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.height.equalTo(0.5)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(secondSeparatorView.snp.bottom).offset(16.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.height.equalTo(300.0)
    }
  }
}
