//
//  Task.swift
//  RxTodoApp
//
//  Created by wtildestar on 13/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
