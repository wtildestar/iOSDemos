//
//  CreateEmployeeVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 29/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit

class CreateEmployeeVC: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        view.backgroundColor = .darkBlue
        setupCancelButton()
        _ = setupLightBlueBackgroundView(height: 50)
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let employeeName = nameTextField.text else { return }
        let error = CoreDataManager.shared.createEmployee(employeeName: employeeName)
        if let error = error {
            // present modal error
            print(error)
        } else {
            dismiss(animated: true)
        }
    }
    
    func setupUI() {
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
