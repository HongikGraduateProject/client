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
  case submit
  
  var title: String? {
    switch self {
    case .leave: return "취소"
    case .submit: return "확인"
    }
  }
  
  var style: UIAlertAction.Style {
    switch self {
    case .leave: return .cancel
    case .submit: return .default
    }
  }
}

final class TodoViewReactor: Reactor, BaseReactorType {
  
  var disposebag = DisposeBag()
  
  enum Action {
    case load
    case selectDay(Date)
  }
  
  enum Mutation {
//    case setSections([TaskListSection])
    case setTasks([Task])
    case setSelectedDayList(Date)
    case insertSectionItem(IndexPath, TaskListSection.Item, Task)
    
  }
  
  struct State {
    var sections: [TaskListSection]
    
    var tasks: [Task]
    var selectedDay: Date = Date()
  }
  
  let provider: ServiceProviderType
  let user: User
  let initialState: State
  let todoRelay = BehaviorRelay<String>(value: "")
  let dateFormatter = DateFormatter().then {
    $0.dateFormat = "yyyy-MM-dd"
    $0.locale = Locale(identifier: "ko_kr")
    $0.timeZone = TimeZone(identifier: "KST")
  }
  
  // MARK: - Initialize
  
  init(_ provider: ServiceProviderType, user: User) {
    self.user = user
    self.provider = provider
    self.initialState = State(sections: [], tasks: [])
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return self.provider.todoService.fetchTask()
        .map { tasks in
          return .setTasks(tasks)
        }
      
    case let .selectDay(date):
      print(date)
      return .just(.setSelectedDayList(date))
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
        let actions: [TaskEditViewCancelAlertAction] = [.leave, .submit]
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
        
          textField.rx.text.orEmpty.subscribe { [weak self] in
            guard let self = self else { return } 
            self.todoRelay.accept($0)
          }
          .disposed(by: self.disposebag)
        }
        //        alert.textFields[0]
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
            let count = self.currentState.sections[0].items.count
            let indexPath = IndexPath(item: count, section: 0)
            let task = Task(contents: self.todoRelay.value, day: self.currentState.selectedDay)
            let reactor = TaskCellReactor(
              self.provider,
              user: self.user,
              task: task
            )
            return self.provider.todoService.create(contents: self.todoRelay.value)
              .map { _ in .insertSectionItem(indexPath, reactor, task) }
            
          }
        }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
      
    case let .insertSectionItem(indexPath, sectionItem, task):
      state.sections.insert(sectionItem, at: indexPath)
      state.tasks.insert(task, at: state.tasks.count)
      
      
      return state
    case let .setTasks(tasks):
      let currentTasks = tasks.filter { $0.date == dateFormatter.string(from: Date())}
      
      state.tasks = tasks
      let sectionItems = currentTasks.map { TaskCellReactor(self.provider, user: self.user, task: $0)}
      let sectionModel = TaskHeaderCellReactor(self.provider, user: self.user)
      let section = TaskListSection(model: sectionModel, items: sectionItems)
      state.sections = [section]
      
    case let .setSelectedDayList(date):
      state.selectedDay = date
      
      let tasks = state.tasks
      let currentTasks = tasks.filter { $0.date == dateFormatter.string(from: date)}
      let sectionItems = currentTasks.map { TaskCellReactor(self.provider, user: self.user, task: $0)}
      let sectionModel = TaskHeaderCellReactor(self.provider, user: self.user)
      let section = TaskListSection(model: sectionModel, items: sectionItems)
      state.sections = [section]
    }
    return state
  }
}

// MARK: - Method

extension TodoViewReactor {
  func reactorForTaskEdit(indexPath: IndexPath) -> TaskEditViewReactor {
    return TaskEditViewReactor(
      provider: self.provider,
      user: self.user, task: currentState.tasks[indexPath.item])
  }
}
