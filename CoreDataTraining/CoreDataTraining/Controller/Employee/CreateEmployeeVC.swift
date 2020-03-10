//
//  CreateEmployeeVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 29/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit

protocol CreateEmployeeDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeVC: UIViewController {
    
    var company: Company?
    
    var delegate: CreateEmployeeDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        return textField
    }()

    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/DD/YYYY"
        return textField
    }()
    
    let employeeTypeSegmentedControl: UISegmentedControl = {
//        let types = ["Executive", "Senior Management", "Staff"]
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue,
            EmployeeType.Intern.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        view.backgroundColor = .darkGray
        setupCancelButton()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let employeeName = nameTextField.text else { return }
        guard let company = self.company else { return }
        guard let birthdayText = birthdayTextField.text else { return }
        
        if birthdayText.isEmpty {
            showError(title: "Empty Birthday", message: "You have not entered a birthday")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText)
            else {
                showError(title: "Bad Date", message: "This date intered not valid")
            return
        }
        
        guard let employeeType =
            employeeTypeSegmentedControl.titleForSegment(at:
            employeeTypeSegmentedControl.selectedSegmentIndex) else
        { return }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, birthday: birthdayDate, company: company)
        if let error = tuple.1 {
            // present modal error
            print(error)
        } else {
            dismiss(animated: true, completion: {
                self.delegate?.didAddEmployee(employee: tuple.0!)   
            })
        }
    }
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "Ok", style: .default)
        )
        present(alertController, animated: true)
    }
    
    func setupUI() {
        _ = setupLightBlueBackgroundView(height: 150)
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.top.equalTo(view)
            //            make.bottom.equalTo(datePicker.snp.top)
        }
        
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(16)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        view.addSubview(birthdayLabel)
        
        birthdayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
        view.addSubview(birthdayTextField)
        
        birthdayTextField.snp.makeConstraints { (make) in
            make.left.equalTo(birthdayLabel.snp.right).offset(16)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(birthdayLabel.snp.bottom)
            make.top.equalTo(birthdayLabel.snp.top)
        }
        
        view.addSubview(employeeTypeSegmentedControl)
        
        employeeTypeSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(birthdayLabel.snp.bottom)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(34)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
