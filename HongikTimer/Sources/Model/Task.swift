//
//  Task.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/28.
//

import Foundation

struct Task: Codable {
  
  var taskId: Int?
  var contents: String?
  var isChecked: Bool?
  let date: String
  
  init(default: Bool) {
    self.contents = "스위프트 문법 공부"
    self.isChecked = false
    self.date = "2022-11-11"
  }
  
  init() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    
    self.date = dateFormatter.string(from: Date())
  }
  
  init(
    contents: String
  ) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    
    self.contents = contents
    self.isChecked = false
    self.date = dateFormatter.string(from: Date())
  }
}
