//
//  UIViewController+Helpers.swift
//  CoreDataTraining
//
//  Created by wtildestar on 29/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        self.modalTransitionStyle = .crossDissolve
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        
        dismiss(animated: true)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        
        view.addSubview(lightBlueBackgroundView)
             
         lightBlueBackgroundView.snp.makeConstraints { (make) in
             make.top.left.right.equalTo(view)
             make.height.equalTo(height)
         }
        
        return lightBlueBackgroundView
    }

}
