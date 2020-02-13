//
//  LoseViewController.swift
//  Cards
//
//  Created by wtildestar on 13/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class LoseViewController: UIViewController {

    public static func storyboardInstance() -> LoseViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoseVC") as? LoseViewController
    }

}
