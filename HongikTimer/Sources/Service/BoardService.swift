//
//  BoardService.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/06.
//

import RxSwift

/// Board Service 관련 이벤트
enum BoardEvent {
  case create(BoardPost)
}

protocol BoardServicType {
  
  var event: PublishSubject<BoardEvent> { get }
  func fetchBoardPosts() -> Observable<[BoardPost]>
  
  @discardableResult
  func saveBoardPosts(_ boarPosts: [BoardPost]) -> Observable<Void>
  
  func create(
    _ title: String,
    maxMemberCount: Int,
    chief: String,
    startDay: Date,
    content: String
  ) -> Observable<BoardPost>
}

final class BoardService: BoardServicType {
  
  let userDefaultservice = UserDefaultService.shared
  let event = PublishSubject<BoardEvent>()

  func fetchBoardPosts() -> Observable<[BoardPost]> {
    if let savedBoardPosts = userDefaultservice.getBoardPosts() {
      return .just(savedBoardPosts)
    }
    
    let defaultPosts: [BoardPost] = [
      BoardPost(), BoardPost(), BoardPost()
    ]
    self.userDefaultservice.setBoardPost(defaultPosts)
    return .just(defaultPosts)
  }
  
  @discardableResult
  func saveBoardPosts(_ boarPosts: [BoardPost]) -> Observable<Void> {
    userDefaultservice.setBoardPost(boarPosts)
    return .just(Void())
  }
  
  func create(
    _ title: String,
    maxMemberCount: Int,
    chief: String,
    startDay: Date,
    content: String
  ) -> Observable<BoardPost> {
    return self.fetchBoardPosts()
      .flatMap { [weak self] boardPosts -> Observable<BoardPost> in
        guard let self = self else { return .empty() }
        let newPost = BoardPost(
          title: title,
          maxMemberCount: maxMemberCount,
          chief: chief,
          startDay: startDay,
          content: content
        )
        return self.saveBoardPosts([newPost] + boardPosts).map { _ in newPost }
      }
      .do(onNext: { boardPost in
        self.event.onNext(.create(boardPost))
      })
  }
}
