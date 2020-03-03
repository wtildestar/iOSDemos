//
//  CompanyCell.swift
//  CoreDataTraining
//
//  Created by wtildestar on 28/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit

class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            guard
                let company = company,
                let imageData = company.imageData
                else { return }
            nameFoundedDateLabel.text = company.name
            companyImageView.image = UIImage(data: imageData)
            
            if let name = company.name, let founded = company.founded {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                
                let dateString = "\(name) - Founded \(foundedDateString)"
                nameFoundedDateLabel.text = dateString
                
            } else {
                nameFoundedDateLabel.text = company.name
            }
        }
    }

    let companyImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
       let label = UILabel()
//        label.text = "COMPANY NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.tealColor
        
        addSubview(companyImageView)
        companyImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.left.equalTo(self).offset(16)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(nameFoundedDateLabel)
        nameFoundedDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(companyImageView.snp.right).offset(8)
            make.top.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
