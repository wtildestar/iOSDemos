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
    //    var counters: [Counters] = []
    var counters: [Counters]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCounters()
        
// tableView.register(CountersViewCell.self, forCellReuseIdentifier: "CountersViewCell")
    }

    func getCounters() {
        NetworkManager.shared.getCounters() { result in
//            guard let self = self else { return }
            
//            print(result)
            switch result {
            case .success(let counters):
                self.counters = counters.data
                print(counters.data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

// MARK: - Table view data source

extension CountersViewController: UITableViewDataSource, UITableViewDelegate {

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return counters?.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountersViewCell") as! CountersViewCell
            
            let counter = counters?[indexPath.row]
            cell.set(counters: counter!)
            return cell
        }
}
