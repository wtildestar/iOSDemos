//
//  CardCell.swift
//  dropDownSpotsApp
//
//  Created by wtildestar on 31/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    // MARK: - Variables
    
    var cellData: CellData! {
        didSet {
            featureImage.image = cellData.featureImage
            titleLabel.text = cellData.title
        }
    }
    
    fileprivate var featureImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 2
        return iv
    }()
    
    fileprivate var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var infoText: UITextView = {
        let infoText = UITextView()
        infoText.font = UIFont.systemFont(ofSize: 12, weight: .light)
        infoText.textColor = .black
        infoText.isEditable = false
        infoText.translatesAutoresizingMaskIntoConstraints = false
        infoText.text = "This series will show you how to build a dropdown spots app."
        infoText.backgroundColor = .clear
        return infoText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundColor = .clear
        setupConstraints()
        
    }
    
    fileprivate var imageHeightOpened: NSLayoutConstraint!
    fileprivate var imageHeightClosed: NSLayoutConstraint!
    
    
    // MARK: - Functionality
    
    fileprivate func setupConstraints() {
        contentView.addSubview(featureImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoText)
        
        featureImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        featureImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        featureImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        imageHeightOpened = featureImage.heightAnchor.constraint(equalToConstant: 140)
        imageHeightClosed = featureImage.heightAnchor.constraint(equalToConstant: 20)
        
        titleLabel.topAnchor.constraint(equalTo: featureImage.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        infoText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4).isActive = true
        infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
    }
    
    func animate() {
        self.imageHeightOpened.isActive = false
        self.imageHeightClosed.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            self.imageHeightClosed.isActive = false
            self.imageHeightOpened.isActive = true
            
            UIView.animate(withDuration: 0.3, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
