//
//  YourScoreViewController.swift
//  Cards
//
//  Created by wtildestar on 10/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class YourScoreViewController: UIViewController {
    
    // MARK: - Properties
    
    var score: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let score = score else { return }
        yourScoreLabel.text = "\(60 - Int(score)!)s"
    }
    
    public static func storyboardInstance() -> YourScoreViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "YourScore") as? YourScoreViewController
    }
    
}
