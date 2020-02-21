//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by wtildestar on 20/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
