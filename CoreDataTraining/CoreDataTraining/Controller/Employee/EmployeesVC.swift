//
//  EmployeesVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 29/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import CoreData

class EmployeesVC: UITableViewController, CreateEmployeeDelegate {
    
    var company: Company?
    var employees = [Employee]()
    let reuseID = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        fetchEmployees()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        self.employees = companyEmployees
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//        do {
//            let employees = try context.fetch(request)
//            self.employees = employees
//            employees.forEach{print("Employee name:", $0.name ?? "")}
//
//        } catch let err {
//            print("Failed to fetch employees:", err)
//        }
    }
    
    @objc func handleAdd() {
        print("add employee")
        let createEmployeeVC = CreateEmployeeVC()
        createEmployeeVC.delegate = self
        createEmployeeVC.company = company
        let nav = UINavigationController(rootViewController: createEmployeeVC)
        nav.modalPresentationStyle = .fullScreen
        createEmployeeVC.modalTransitionStyle = .crossDissolve
        present(nav, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let birthday = employee.employeeInformation?.birthday {
            cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
        }
        
        
        //        if let taxId = employee.employeeInformation?.taxId {
        //            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
        //        }
        
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employees.count
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
