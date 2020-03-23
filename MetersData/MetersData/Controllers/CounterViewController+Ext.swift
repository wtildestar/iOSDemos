//
//  CounterViewController+Ext.swift
//  MetersData
//
//  Created by wtildestar on 18/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension CountersViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return counters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CountersViewCell
//        header.tapHandler = { [unowned self] _ in
//            print(self.counters![section].id)
//        }
//        return header
//
////        headerView.backgroundColor = UIColor.clear
////        return headerView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountersViewCell") as! CountersViewCell

        let counter = counters?[indexPath.section]
        cell.set(counters: counter!)
        
        cell.layer.borderColor = UIColor.systemGreen.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        let countersTextField = CountersTextField()
        countersTextField.tapHandler = { [unowned self] _ in
            print(self.counters![indexPath.section].id)
        }
        
        return cell
    }
}

public extension UITableView {

    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = self.convert(center, from: view.superview)
        let indexPath = self.indexPathForRow(at: viewCenter)
        return indexPath
    }
}
