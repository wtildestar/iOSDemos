//
//  CreateCompanyVC.swift
//  CoreDataTraining
//
//  Created by wtildestar on 26/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

protocol CreateCompanyVCDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyVC: UIViewController {
    
    var delegate: CreateCompanyVCDelegate?

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
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleSave() {
        print("save")
        
        // Init coreData stack
        
        let persi
        
//        dismiss(animated: true) {
//            guard let name = self.nameTextField.text else { return }
//            let company = Company(name: name, founded: Date())
//            self.delegate?.didAddCompany(company: company)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.darkBlue
        setupUI()
        
    }
    
    private func setupUI() {
        
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        
        view.addSubview(lightBlueBackgroundView)
             
             lightBlueBackgroundView.snp.makeConstraints { (make) in
                 make.top.left.right.equalTo(view)
                 make.height.equalTo(50)
             }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(16)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.top.equalTo(nameLabel.snp.top)
        }
    }
    
}
