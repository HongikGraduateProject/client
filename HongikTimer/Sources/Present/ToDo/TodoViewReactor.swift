//
//  TodoViewReactor.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/13.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxDataSources
import URLNavigator

typealias TaskListSection = SectionModel<TaskHeaderCellReactor, TaskCellReactor>

enum TaskEditViewCancelAlertAction: AlertActionType {
  case leave
  case stay
  
  var title: String? {
    switch self {
    case .leave: return "취소"
    case .stay: return "확인"
    }
  }
  
  var style: UIAlertAction.Style {
    switch self {
    case .leave: return .cancel
    case .stay: return .default
    }
  }
}

final class TodoViewReactor: Reactor, BaseReactorType {
  
  var disposebag = DisposeBag()
  
  enum Action {
    case refresh
  }
  
  enum Mutation {
    case setSections([TaskListSection])
    
//    case presentCreate
  }
  
  struct State {
    var sections: [TaskListSection]
    @Pulse var presentTextField: Bool = false
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State
  let todoRelay = BehaviorRelay<String>(value: "")
  
  // MARK: - Initialize
  
  init(_ provider: ServiceProviderType, user: User) {
    self.user = user
    self.provider = provider
    self.initialState = State(sections: [])
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .refresh:
      return self.provider.todoService.fetchTask()
        .map { tasks in
          let sectionItems = tasks.map { TaskCellReactor(self.provider, user: self.user, task: $0) }
          
          let sectionModel = TaskHeaderCellReactor(self.provider, user: self.user)
          let section = TaskListSection(model: sectionModel, items: sectionItems)
          return .setSections([section])
        }
    }
  }
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    let headerEventMutation = self.provider.todoService.headerEvent
      .flatMap { [weak self] headerEvent -> Observable<Mutation> in
        self?.mutate(headerEvent: headerEvent) ?? .empty()
      }
    return Observable.of(mutation, headerEventMutation).merge()
  }
  
  func mutate(headerEvent: HeaderEvent) -> Observable<Mutation> {
    switch headerEvent {
    case .create:
      let observer = Observable.create { observer in
        let actions: [TaskEditViewCancelAlertAction] = [.leave, .stay]
        let alert = UIAlertController(title: "Todo", message: nil, preferredStyle: .alert)
        for action in actions {
          let alerAction = UIAlertAction(title: action.title, style: action.style) { _ in
            observer.onNext(action)
            observer.onCompleted()
          }
          alert.addAction(alerAction)
        }
        alert.addTextField { textField in
          textField.placeholder = "할일을 입력하세요!"
          
          //          todoRelay.accept(textField.rx.text)
          textField.rx.text.orEmpty.subscribe { [weak self] in
            guard let self = self else { return }
            self.todoRelay.accept($0)
          }
          .disposed(by: self.disposebag)
        }
        //        alert.textFields[0]?.rx
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
          case .stay:
            print(self.todoRelay.value)
            let task = Task(contents: self.todoRelay.value)
            
            
            return  .empty()
          }
        }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case let .setSections(sections):
      state.sections = sections
      
      print("리로로로로롤들 하빈다.")
      
//    case .presentCreate:
//      state.presentTextField = true
    }
    
    return state
  }
}

// MARK: - Method
