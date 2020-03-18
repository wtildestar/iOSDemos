//
//  User.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct User: Encodable {
    var emailOrPhone: String
    var password: String
    var isMobile: Bool
}
