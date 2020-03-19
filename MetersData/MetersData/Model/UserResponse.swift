//
//  UserResponse.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let isSuccess: Bool
    var data: String
    let typeAccount: String
}
