//
//  CoutnersViewCell.swift
//  MetersData
//
//  Created by wtildestar on 17/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class CountersViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var counterImageView: UIImageView!
    @IBOutlet weak var counterId: UILabel!
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterUnit: UILabel!
    @IBOutlet weak var lastValueTextFieldOne: UITextField!
    @IBOutlet weak var lastValueTextFieldTwo: UITextField!
    
    // MARK: - Properties
    var emptyImage = UIImage(named: "empty_img")
    
    // MARK: - Methods
    func set(counters: Counters) {
        if let imgUrl = counters.type?.equipmentSection?.image {
            getImg(url: imgUrl)
        } else {
            self.counterImageView.image = emptyImage
        }
        
        let fullCounterLastValue    = counters.lastValue
        let fullCounterLastValueArr = fullCounterLastValue!.components(separatedBy: ".")

        let val1String = fullCounterLastValueArr[0]
        let val2String = fullCounterLastValueArr[1]
        
        counterId.text              = String(counters.id)
        counterTitle.text           = counters.type?.equipmentSection?.title ?? ""
        lastValueTextFieldOne.text  = val1String
        lastValueTextFieldTwo.text  = val2String
        counterUnit.text            = counters.type?.unit ?? ""
    }
    
    func getImg(url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.counterImageView.image = image
            }
        }
    }
    
}
