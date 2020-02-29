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
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
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
