//
//  TaskEditView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import UIKit
import Then
import ReactorKit

final class TaskEditViewController: BaseViewController, View {
  
  // MARK: - Property
  
  private var hasSetPointOrigin = false
  private var pointOrigin: CGPoint?
    
  // MARK: - UI
  
  private lazy var sliderIndicator = UIView().then {
    $0.backgroundColor = .systemGray
    $0.layer.cornerRadius = 2
  }
  
  private lazy var todoLabel = UILabel().then {
    $0.font = .systemFont(
      ofSize: 16.0
    )
    $0.textColor = .label
  }
  
  private lazy var editButton = UIButton()
  private lazy var deleteButton = UIButton()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setGesture()
  }
  
  override func viewDidLayoutSubviews() {
    if !hasSetPointOrigin {
      hasSetPointOrigin = true
      pointOrigin = self.view.frame.origin
    }
  }
  
  // MARK: - Init
  
  init(_ reactor: TaskEditViewReactor) {
    super.init()
    
    self.reactor = reactor
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Binding
  
  func bind(reactor: TaskEditViewReactor) {
    
    // action
    deleteButton.rx.tap
      .map { Reactor.Action.delete }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    editButton.rx.tap
      .map { Reactor.Action.edit }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // state
    reactor.state.asObservable().map { $0.task }
      .subscribe(onNext: { [weak self] task in
        self?.todoLabel.text = task.contents
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.asObservable().map { $0.isDismissed }
      .distinctUntilChanged()
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true)
      })
      .disposed(by: self.disposeBag)
  }
}

// MARK: - Private

private extension TaskEditViewController {
  func setupLayout() {
    
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = .systemGray4
    config.baseForegroundColor = .label
    
    config.imagePlacement = .top
    config.imagePadding = 4.0
    config.titlePadding = 4.0
    
    editButton.configuration = config
    editButton.configuration?.title = "수정"
    editButton.configuration?.image = UIImage(named: "pencil")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    
    deleteButton.configuration = config
    deleteButton.configuration?.title = "삭제"
    deleteButton.configuration?.image = UIImage(named: "trashCan")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    
    view.backgroundColor = .systemBackground
    
    let buttonStackView = UIStackView(
      arrangedSubviews: [
        editButton,
        deleteButton
      ]
    ).then {
      $0.axis = .horizontal
      $0.distribution = .fillEqually
      $0.spacing = 8.0
    }
    
    [
      sliderIndicator,
      todoLabel,
      buttonStackView
    ].forEach { view.addSubview($0) }
    
    sliderIndicator.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(16.0)
      $0.width.equalTo(40.0)
      $0.height.equalTo(4.0)
    }
    
    todoLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.top.equalToSuperview().inset(64.0)
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(todoLabel.snp.bottom).offset(16.0)
      $0.leading.trailing.equalTo(todoLabel)
    }
  }
  
  func setGesture() {
    let panGesture = UIPanGestureRecognizer(
      target: self,
      action: #selector(panGestureRecognizerAction)
    )
    view.addGestureRecognizer(panGesture)
  }
  
  // MARK: - Selector
  
  @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    // Not allowing the user to drag the view upward
    guard translation.y >= 0 else { return }
    
    // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
    view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
    
    if sender.state == .ended {
      let dragVelocity = sender.velocity(in: view)
      if dragVelocity.y >= 1300 {
        self.dismiss(animated: true, completion: nil)
      } else {
        // Set back to original position of the view controller
        UIView.animate(withDuration: 0.3) {
          self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
        }
      }
    }
  }
}
