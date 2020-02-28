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
    func didEditCompany(company: Company)
}

class CreateCompanyVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var delegate: CreateCompanyVCDelegate?
    
    var company: Company? {
        didSet {
            guard
                let imageData = company?.imageData,
                let founded = company?.founded
                else { return }
            imageView.image = UIImage(data: imageData)
            imageView.contentMode = .scaleAspectFill
            nameTextField.text = company?.name
            datePicker.date = founded
            setupCircularImageStyle()
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
    
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    // MARK: - Selector methods
    
    @objc private func handleSelectPhoto() {
        print("Trying to select photo..")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.modalPresentationStyle = .fullScreen
        present(imagePickerController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        setupCircularImageStyle()
        dismiss(animated: true)
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleSave() {
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
    }
    
    private func saveCompanyChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let imageView = imageView.image else { return }
        let imageData = imageView.jpegData(compressionQuality: 0.8)
        company?.imageData = imageData
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch let saveErr {
            print("Failed to save company changes: ", saveErr)
        }
    }
    
    private func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        guard let imageView = imageView.image else { return }
        let imageData = imageView.jpegData(compressionQuality: 0.8)
        
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        company.setValue(imageData, forKey: "imageData")
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
        } catch let saveErr {
            print("Failed to save company: ", saveErr)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemSetup()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor.darkBlue
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        
        view.addSubview(lightBlueBackgroundView)
             
         lightBlueBackgroundView.snp.makeConstraints { (make) in
             make.top.left.right.equalTo(view)
             make.height.equalTo(350)
         }
        
        view.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.top.equalTo(view.snp.top).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(16)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.top.equalTo(imageView.snp.bottom)
//            make.bottom.equalTo(datePicker.snp.top)
        }
        
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(16)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(lightBlueBackgroundView.snp.bottom)
        }
    }
    
    private func navigationItemSetup() {
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupCircularImageStyle() {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 2
    }
    
}
