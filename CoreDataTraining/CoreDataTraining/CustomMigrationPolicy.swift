//
//  CustomMigrationPolicy.swift
//  CoreDataTraining
//
//  Created by wtildestar on 03/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import CoreData

class CustomMigrationPolicy: NSEntityMigrationPolicy {
    // type our transformation function here in just a bit
    
    @objc func transformNumEmployees(forNum: NSNumber) -> String {
        if forNum.intValue < 150 {
            return "small"
        } else {
            return "very large"
        }
    }
}
