//
//  BoardPost.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/04.
//

import Foundation

struct BoardPost: Codable, Identifiable, Equatable {
  var id = UUID().uuidString
  var title: String
  var member: String
  var chief: String
  var start: String
  var totalTime: String
  var content: String
  
  init() {
    self.title = "파이썬 코테 스터디"
    self.member = "1/3명"
    self.chief = "영미"
    self.start = "22. 4. 11"
    self.totalTime = "5시간 23분"
    self.content = "파이썬 코딩테스트 모집합니다~~파이썬 코딩테스트 모집합니다~~파이썬 코딩테스트 모집합니다~~파이썬 코딩테스트 모집합니다~~"
  }
  
  init(title: String, content: String, member: String) {
    self.title = title
    self.content = content
    self.member = member
    self.chief = "영미"
    self.start = "22. 4. 11"
    self.totalTime = "5시간 23분"
  }
}
