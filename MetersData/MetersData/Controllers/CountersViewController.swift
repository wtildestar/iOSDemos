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
//    var counterNewValue:                     CounterNewValue?
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
        NetworkManager.shared.sendCounters(counterNewValue: sendingCounters) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Sending error", message: "Unable to send counters data to server")
                }
                print(error)
            }
        }
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
        if !sendingCounters.isEmpty {
            sendCounter()
        } else {
            DispatchQueue.main.async {
                self.showAlertWith(title: "Nothing to send", message: "Your counters aren't changed, please edit them")
            }
        }
        DispatchQueue.main.async {
            self.showAlertWith(title: "Sending succefully", message: "Your counters sended completed to server")
        }
    }
}

