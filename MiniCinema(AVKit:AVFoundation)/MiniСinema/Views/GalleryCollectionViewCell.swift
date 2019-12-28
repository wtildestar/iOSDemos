//
//  GalleryCollectionViewCell.swift
//  MiniСinema
//
//  Created by Алексей Пархоменко on 11/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseId = "GalleryCollectionViewCell"
    
    var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    var filmNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var video: Video? = nil {
        didSet {
            photoImageView.image = video?.filmImage
            filmNameLabel.text = video?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        addSubview(filmNameLabel)
        
        constraints()
    }
    
    func constraints() {
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3/4).isActive = true
        
        filmNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -10).isActive = true
        filmNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        filmNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        filmNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.photoImageView.layer.cornerRadius = 10
        self.photoImageView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
