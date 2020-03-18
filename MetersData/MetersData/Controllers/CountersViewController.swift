//
//  CountersViewController.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CountersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var counters:                 [Counters]?
    var counterNewValue:          CounterNewValue?
    var countersViewCell:         CountersViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCounters()
    }

    func getCounters() {
        NetworkManager.shared.getCounters() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let counters):
                self.counters = counters.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendCounter() {
        guard let counterNewValue = counterNewValue else { return }
        NetworkManager.shared.sendCounters(counterNewValue: counterNewValue) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    @IBAction func sendCountersActionButton(_ sender: UIBarButtonItem) {
        guard
            let id = Int(self.countersViewCell?.counterId.text ?? "0"),
            let val1Str = self.countersViewCell?.lastValueTextFieldOne.text,
            let val2Str = self.countersViewCell?.lastValueTextFieldTwo.text else { return }
        counterNewValue = CounterNewValue(id: id, val1Str: val1Str, val2Str: val2Str)
        sendCounter()
        print("counters was sended")
    }
}
