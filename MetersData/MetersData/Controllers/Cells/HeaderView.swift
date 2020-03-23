//
//  HeaderView.swift
//  MetersData
//
//  Created by wtildestar on 22/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CountersTextField: UITextField {
    
    var tapHandler: ((CountersTextField) -> Void)!
    
//    init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
//
//    override init(style: CellView.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
//    }
    
    @objc private func tapAction() {
        tapHandler?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
