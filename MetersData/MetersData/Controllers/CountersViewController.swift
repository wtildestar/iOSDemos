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
    @IBOutlet weak var counterTableView: UITableView!
//    {
//        didSet {
//            counterTableView.register(CountersViewCell.self, forHeaderFooterViewReuseIdentifier: "CountersViewCell")
//        }
//    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var counters:                 [Counters]?
    var counterNewValue:          CounterNewValue?
    var userResponse:             UserResponse?
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getCounters()
        }
//        print(counters!.count)
    }

    // MARK: - Methods
    func getCounters() {
//        guard let userResponse = userResponse else { return }
        NetworkManager.shared.getCounters() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let counters):
                self.counters = counters.data
                DispatchQueue.main.async {
                    self.counterTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        activityIndicator.stopAnimating()
        let ud = UserDefaults.standard.string(forKey: "token")
        print(ud!)
    }
    
    func sendCounter(counterModel: CounterNewValue?) {
        guard let counterModel = counterModel else { return }
        NetworkManager.shared.sendCounters(counterNewValue: counterModel) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
//    private func takeIndex(for index: IndexPath) {
//        let cell = counterTableView.dequeueReusableCell(withIdentifier: "CountersViewCell", for: index) as? CountersViewCell
//        let cell = counterTableView.cellForRow(at: index) as? CountersViewCell
//    }
    
    @IBAction func sendCountersActionButton(_ sender: UIBarButtonItem) {
        guard let counters = counters else { return }
        var count = 0
        
        for element in counters {
            let index = IndexPath(row: 0, section: count)
            let cell = counterTableView.cellForRow(at: index) as? CountersViewCell
            
            //                if element.id == Int(cell.counterId.text!) {
            //                    self.counterNewValue!.id = element.id
            //                }
            let val1 = element.lastValue?.components(separatedBy: ".")[0]
            let val2 = element.lastValue?.components(separatedBy: ".")[1]
            
            
            var newValue1 = cell?.lastValueTextFieldOne.text
            var newValue2 = cell?.lastValueTextFieldTwo.text
            
            //
            if cell?.lastValueTextFieldOne == nil {
                newValue1 = "0"
            }
            if cell?.lastValueTextFieldTwo == nil {
                newValue2 = "0"
            }

            guard
                let valx1 = val1,
                let valx2 = val2,
                let newValuex1 = newValue1,
                let newValuex2 = newValue2 else {
                    return
            }

            print("val1", valx1, "val2", valx2, "newValue1", newValuex1, "newValue2", newValuex2)
            if val1 != newValue1 ?? "0" || val2 != newValue2 ?? "0" {
                let newVal1Str = "\(newValue1 ?? "0").\(newValue2 ?? "0")"
                self.counterNewValue?.val1Str = newVal1Str
                let counterModel = CounterNewValue(id: element.id, val1Str: newVal1Str, val2Str: "0")
                
                sendCounter(counterModel: counterModel)
                print("counters was sended", counterModel)
            }
            count += 1
        }
    }
}
