//
//  Follower.swift
//  GHFollowers
//
//  Created by wtildestar on 15/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

// Hashable for UICollectionViewDiffableDataSource
struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
