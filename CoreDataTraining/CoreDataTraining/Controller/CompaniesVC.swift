//
//  CompaniesVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 24/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import CoreData

class CompaniesVC: UITableViewController, CreateCompanyVCDelegate {
    func didEditCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    // MARK: - Properties
    
    private let reuseId = "cell"
    
    var companies = [Company]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        setupTableViewStyle()
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    // MARK: - Methods
    
    private func fetchCompanies() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch companies:", fetchErr)
        }
    }
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        cell.backgroundColor = .tealColor
        let company = companies[indexPath.row]
        
        if let name = company.name, let founded = company.founded {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let foundedDateString = dateFormatter.string(from: founded)
            
            let dateString = "\(name) - Founded \(foundedDateString)"
            cell.textLabel?.text = dateString
            
        } else {
            
            cell.textLabel?.text = company.name
            
        }
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.imageView?.image = #imageLiteral(resourceName: "select_photo_empty")
        
        if let imageData = company.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _  in
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete company: ", saveErr)
            }
        })
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, View, completion) in
            let editCompanyVC = CreateCompanyVC()
            editCompanyVC.delegate = self
            editCompanyVC.company = self.companies[indexPath.row]
            let navController = CustomNavigationController(rootViewController: editCompanyVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
            completion(true)
        }
        editAction.backgroundColor = UIColor.darkBlue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func setupTableViewStyle() {
        tableView.backgroundColor = UIColor.darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
    }
    
    // MARK: - CreateCompanyVCDelegate
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
