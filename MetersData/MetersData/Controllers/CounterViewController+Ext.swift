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
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index!)) as? CountersViewCell
        
        var tf1 = cell?.lastValueTextFieldOne.text
        var tf2 = cell?.lastValueTextFieldTwo.text
        let counterId  = Int((cell?.counterId.text)!)
              
        if cell?.lastValueTextFieldOne.text == "" {
            tf1 = "0"
        }
        if cell?.lastValueTextFieldTwo.text == "" {
            tf2 = "0"
        }
        
        guard let tfOne = tf1, let tfTwo = tf2, let id = counterId else { return }

        let counterNewValue = CounterNewValue(id: id, val1Str: tfOne + "." + tfTwo, val2Str: "0")
        
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

extension CountersViewController {
    
    private func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}

