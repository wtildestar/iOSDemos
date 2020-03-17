//
//  Counters.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct Data: Codable {
    let isSuccess: Bool
    let data: [Counters]
}

struct Counters: Codable {
    let id: Int
    let lastValue: String?
    let type: Type?
}

struct Type: Codable {
    let unit: String?
    let equipmentSection: EquipmentSection?
}

struct EquipmentSection: Codable {
    let title: String?
    let image: String?
}
