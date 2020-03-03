//
//  CompaniesVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 24/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import CoreData

class CompaniesVC: UITableViewController {
    
    // MARK: - Properties
    
    var companies = [Company]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companies = CoreDataManager.shared.fetchCompanies()
        setupTableViewStyle()
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.title = "Companies"
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset)),
            UIBarButtonItem(title: "Nested Updates", style: .plain, target: self, action: #selector(doNestedUpdates))
        ]
    }
    
    @objc private func doNestedUpdates() {
        print("Trying to persform nested updates now..")
        
        DispatchQueue.global(qos: .background).async {
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            let request: NSFetchRequest<Company> = Company.fetchRequest()
            request.fetchLimit = 1
            do {
                let companies = try privateContext.fetch(request)
                
                companies.forEach({ (company) in
                    print(company.name ?? "")
                    company.name = "D: \(company.name ?? "")"
                })
                
                do {
                    try privateContext.save()
                    
                    DispatchQueue.main.async {
                        do {
                            let context = CoreDataManager.shared.persistentContainer.viewContext
                            if context.hasChanges {
                                try context.save()
                            }
                            self.tableView.reloadData()
                            
                        } catch let finalSaveErr {
                            print("Failed to save main context:", finalSaveErr)
                        }
                        
                        
                    }
                } catch let saveErr {
                    print("Failed to save private context:", saveErr)
                }
                
                
            } catch let fetchErr {
                print("Failed to fetch on private context:", fetchErr)
            }
            
        }
    }
    
//    @objc private func doUpdate() {
//        print("trying update..")
//
//        CoreDataManager.shared.persistentContainer.performBackgroundTask { (backgroundContext) in
//            let request: NSFetchRequest<Company> = Company.fetchRequest()
//
//            do {
//                let companies = try backgroundContext.fetch(request)
//
//                companies.forEach({ (company) in
//                    print(company.name ?? "")
//                    company.name = "D: \(company.name ?? "")"
//                })
//
//                do {
//                    try backgroundContext.save()
//
//                    DispatchQueue.main.async {
//                        CoreDataManager.shared.persistentContainer.viewContext.reset()
//                        self.companies = CoreDataManager.shared.fetchCompanies()
//                        self.tableView.reloadData()
//                    }
//                } catch let saveErr {
//                    print("Failed to save background:", saveErr)
//                }
//
//            } catch let err {
//                print("Failed to fetch companies on background:", err)
//            }
//        }
//    }
    
//    @objc private func doWork() {
//        print("trying to do work..")
////        let context = CoreDataManager.shared.persistentContainer.viewContext
//
//
//        CoreDataManager.shared.persistentContainer.performBackgroundTask { (backgroundContext) in
//            (0...20000).forEach { (value) in
//                print(value)
//                let company = Company(context: backgroundContext)
//                company.name = String(value)
//            }
//
//            do {
//                try backgroundContext.save()
//            } catch let err {
//                print("Failed to save: ", err)
//            }
//        }
//
//    }
    
    // MARK: - Methods
    
    @objc private func handleAddCompany() {
        let createVC = CreateCompanyVC()
        let nav = CustomNavigationController(rootViewController: createVC)
        nav.modalPresentationStyle = .fullScreen
    
        createVC.delegate = self
        createVC.modalTransitionStyle = .crossDissolve
        present(nav, animated: true)
    }
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .top)
            
        } catch let delErr {
            print("Failed to delete objects from CoreData: ", delErr)
        }
    }
    
    func setupTableViewStyle() {
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
    }
    
}
