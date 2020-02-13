//
//  YourTimeViewController.swift
//  Cards
//
//  Created by wtildestar on 10/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class YourTimeViewController: UIViewController {
    
    // MARK: - Properties
    
    var time: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var yourTimeLabel: UILabel!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let time = time else { return }
        yourTimeLabel.text = "\(60 - Int(time)!)s"
    }
    
    public static func storyboardInstance() -> YourTimeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "YourTime") as? YourTimeViewController
    }
    
}
