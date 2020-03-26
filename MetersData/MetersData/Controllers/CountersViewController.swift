//
//  CountersViewController.swift
//  MetersData
//
//  Created by wtildestar on 16/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CountersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var counters:                            [Counters]?
    var counterNewValue:                     CounterNewValue?
    var userResponse:                        UserResponse?
    var sendingCounters: [CounterNewValue] = []
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            self.getCounters()
        }
        
        tapView()
        setupView()
        setupRefreshController()
    }

    // MARK: - Methods
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
        tableView.refreshControl?.endRefreshing()
        activityIndicator.stopAnimating()
        let ud = UserDefaults.standard.string(forKey: "token")
        print(ud!)
    }
    
    func sendCounter() {
//        guard let counterModel = counterModel else { return }
        NetworkManager.shared.sendCounters() { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlertSendingError()
                }
                print(error)
            }
        }
    }
    
    private func showAlertSendingError() {
        let alertController = UIAlertController(title: "Sending error", message: "Unable to send counters data to server", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func showAlertSendingSuccess() {
        let alertController = UIAlertController(title: "Sending succefully", message: "Your counters sended completed to server", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    func showAlertSendingEmpty() {
        let alertController = UIAlertController(title: "Nothing to send", message: "Your counters aren't changed, please edit them", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func tapView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupView() {
        tableView.keyboardDismissMode = .interactive
        title = "Counters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func handleRefresh() {
        getCounters()
        sendingCounters = []
    }
    
    private func setupRefreshController() {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControll.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControll.attributedTitle = NSAttributedString(string: "Получение данных счетчиков...")
        tableView.refreshControl = refreshControll
    }
    
    @IBAction func sendCountersActionButton(_ sender: UIBarButtonItem) {
//        if !sendingCounters.isEmpty {
//            for counter in sendingCounters {
                sendCounter()
//            }
            showAlertSendingSuccess()
//        } else {
//            showAlertSendingEmpty()
//        }
        
        
//        guard let counters = counters else { return }
//        var count = 0
//
//        for element in counters {
//            let index = IndexPath(row: 0, section: count)
//            let cell = counterTableView.cellForRow(at: index) as? CountersViewCell
//
//            let val1 = element.lastValue?.components(separatedBy: ".")[0]
//            let val2 = element.lastValue?.components(separatedBy: ".")[1]
//
//
//            var newValue1 = cell?.lastValueTextFieldOne.text
//            var newValue2 = cell?.lastValueTextFieldTwo.text
//
//            if cell?.lastValueTextFieldOne == nil {
//                newValue1 = "0"
//            }
//            if cell?.lastValueTextFieldTwo == nil {
//                newValue2 = "0"
//            }
//
//            guard
//                let valx1 = val1,
//                let valx2 = val2,
//                let newValuex1 = newValue1,
//                let newValuex2 = newValue2 else {
//                    return
//            }
//
//            print("val1", valx1, "val2", valx2, "newValue1", newValuex1, "newValue2", newValuex2)
//            if val1 != newValue1 ?? "0" || val2 != newValue2 ?? "0" {
//                let newVal1Str = "\(newValue1 ?? "0").\(newValue2 ?? "0")"
//                self.counterNewValue?.val1Str = newVal1Str
//                let counterModel = CounterNewValue(id: element.id, val1Str: newVal1Str, val2Str: "0")
//
//                sendCounter(counterModel: counterModel)
//                print("counters was sended", counterModel)
//            }
//            count += 1
//        }
    }
}

