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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
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
        
        cell.lastValueTextFieldOne.tag = indexPath.section
        cell.lastValueTextFieldTwo.tag = indexPath.section
        cell.lastValueTextFieldOne.addTarget(self, action: #selector(tfEdited), for: .editingDidEnd)
        cell.lastValueTextFieldTwo.addTarget(self, action: #selector(tfEdited), for: .editingDidEnd)
        
        return cell
    }
    
    @objc func tfEdited(sender: AnyObject) {
        
        let index = sender.tag
        let cell = counterTableView.cellForRow(at: IndexPath(row: 0, section: index!)) as? CountersViewCell
        
        let tf1 = cell?.lastValueTextFieldOne.text
        let tf2 = cell?.lastValueTextFieldTwo.text
        
        let counterNewValue = CounterNewValue(id: Int((cell?.counterId.text)!)!, val1Str: tf1! + "." + tf2!, val2Str: "0")
        
        if sendingCounters.contains(counterNewValue) {
            print("sendingCounters Contains counterNewValue", counterNewValue)
            
            for (index, item) in sendingCounters.enumerated() {
            print("INDEX", index, item)
                if item.id == counterNewValue.id {
                    print("index.id == counterNewValue.id: ", item, "index: ", index)
                    sendingCounters.remove(at: index)
                    sendingCounters.insert(counterNewValue, at: index)
                }
            }
        } else if cell!.counterTitle.text != "Электроэнергия" {
            sendingCounters.append(counterNewValue)
        } else { return }
        print("Finite sendingCounters: ", sendingCounters)
    }
}

