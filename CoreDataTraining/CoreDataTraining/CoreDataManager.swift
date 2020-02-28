//
//  CoreDataManager.swift
//  CoreDataTraining
//
//  Created by wtildestar on 26/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTrainingModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError( "Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
            
        } catch let fetchErr {
            print("Failed to fetch companies:", fetchErr)
            return []
        }
    }
}
