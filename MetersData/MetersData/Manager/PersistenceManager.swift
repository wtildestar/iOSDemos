//
//  PersistenceManager.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let bearerToken = "bearer"
    }
    
    static func save(userResponse: UserResponse) -> MDError? {
        
        do {
            let encoder = JSONEncoder()
            let encoderBearer = try encoder.encode(userResponse)
            defaults.set(encoderBearer, forKey: Keys.bearerToken)
            return nil
        } catch {
            return .invalidToUserResponse
        }
    }
}
