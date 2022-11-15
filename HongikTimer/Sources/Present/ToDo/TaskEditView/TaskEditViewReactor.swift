//
//  TaskEditViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/15.
//

import ReactorKit
import RxCocoa
import RxSwift
import URLNavigator

final class TaskEditViewReactor: Reactor, BaseReactorType {
    
  enum Action {
    case edit
    case delete
  }
  
  enum Mutation {
    case dismiss
    case empty
  }
  
  struct State {
    let task: Task
    var isDismissed: Bool = false
  }
  
  let user: User
  let provider: ServiceProviderType
  let initialState: State
  var todoRelay = BehaviorRelay<String>(value: "")
  var disposebag = DisposeBag()
  
  init(provider: ServiceProviderType, user: User, task: Task) {
    self.provider = provider
    self.user = user
    self.initialState = State(task: task)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .delete:
      return self.provider.todoService.tapDeleteButton()
        .map { _ in .dismiss }
    case .edit:
      let observer = Observable.create { observer in
        let actions: [TaskEditAlertAction] = [.leave, .submit]
        let alert = UIAlertController(title: "Todo", message: nil, preferredStyle: .alert)
        for action in actions {
          let alerAction = UIAlertAction(title: action.title, style: action.style) { _ in
            observer.onNext(action)
            observer.onCompleted()
          }
          alert.addAction(alerAction)
        }
        alert.addTextField { [weak self] textField in
          guard let self = self else { return }
          textField.text = self.currentState.task.contents
        
          textField.rx.text.orEmpty.subscribe { [weak self] in
            guard let self = self else { return }
            self.todoRelay.accept($0)
          }
          .disposed(by: self.disposebag)
        }
        Navigator().present(alert)
        return Disposables.create {
          alert.dismiss(animated: true)
        }
      }
      
      // TODO: weak self?
      return observer
        .flatMap { alertAction -> Observable<Mutation> in
          switch alertAction {
          case .leave:
            return .empty()
          case .submit:
            return self.provider.todoService.tapEditButton()
              .map { _ in .dismiss }
          }
        }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
    var state = state
    
    switch mutation {
    case .dismiss:
      state.isDismissed = true

    case .empty:
      return state
    }

    return state
  }
}
