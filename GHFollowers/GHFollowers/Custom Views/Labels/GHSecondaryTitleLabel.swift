//
//  GHSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by wtildestar on 18/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class GHSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    private func configure() {
        // .label for light/dark mode screen
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        // format like name...
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
