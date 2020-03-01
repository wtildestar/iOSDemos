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
        print("Trying to fetch companies")
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
    
    func createEmployee(employeeName: String, birthday: Date, company: Company) -> (Employee?, Error?) {
        print("create employee..")
        let context = persistentContainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.company = company
        employee.setValue(employeeName, forKey: "name")
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        employeeInformation.taxId = "456"
        employeeInformation.birthday = birthday
//        employeeInformation.setValue("456", forKey: "taxId")
        employee.employeeInformation = employeeInformation
        
        do {
            try context.save()
            return (employee, nil)
            
        } catch let err {
            print("Failed to create employee", err)
            return (nil, err)
        }
        
    }
}
