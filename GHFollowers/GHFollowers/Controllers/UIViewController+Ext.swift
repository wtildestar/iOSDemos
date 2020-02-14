//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by wtildestar on 14/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentGHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
