//
//  CounterNewValue.swift
//  MetersData
//
//  Created by wtildestar on 18/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct CounterNewValue: Codable, Equatable {
    var id: Int
    var val1Str: String?
    var val2Str: String?
    
    static func ==(lhs:CounterNewValue, rhs:CounterNewValue) -> Bool { // Implement Equatable
        return lhs.id == rhs.id
    }
}


