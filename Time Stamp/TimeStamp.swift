//
//  TimeStamp.swift
//  Time Stamp
//
//  Created by Steve on 2020-04-01.
//  Copyright © 2020 Steve. All rights reserved.
//

import Foundation

struct TimeStamp {
  let text: String
  let author: String
  
  static let all: [TimeStamp] =  [
    TimeStamp(text: "Never put off until tomorrow what you can do the day after tomorrow.", author: "Mark Twain"),
    TimeStamp(text: "Efficiency is doing better what is already being done.", author: "Peter Drucker"),
    TimeStamp(text: "To infinity and beyond!", author: "Buzz Lightyear"),
    TimeStamp(text: "May the Force be with you.", author: "Han Solo"),
    TimeStamp(text: "Simplicity is the ultimate sophistication", author: "Leonardo da Vinci"),
    TimeStamp(text: "It’s not just what it looks like and feels like. Design is how it works.", author: "Steve Jobs")
  ]
}

extension TimeStamp: CustomStringConvertible {
  var description: String {
    return "model"
  }
}
