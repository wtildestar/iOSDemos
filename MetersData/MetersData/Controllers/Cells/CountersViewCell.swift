//
//  CoutnersViewCell.swift
//  MetersData
//
//  Created by wtildestar on 17/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CountersViewCell: UITableViewCell {

    @IBOutlet weak var counterId: UILabel!
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterUnit: UILabel!
    @IBOutlet weak var lastValueTextField: UITextField!
    
    func set(counters: Counters) {
        counterId.text = String(counters.id)
        counterTitle.text = counters.type?.equipmentSection?.title ?? ""
        lastValueTextField.text = counters.lastValue ?? ""
        counterUnit.text = counters.type?.unit ?? ""
    }
    
}
