//
//  GHButton.swift
//  GHFollowers
//
//  Created by wtildestar on 13/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class GHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius     = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font       = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
