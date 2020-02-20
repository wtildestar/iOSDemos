//
//  MenuViewController.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: - Properties
    
    private var webKitURL: String?
    
    // MARK: - Actions
    
    @IBAction func playButton(_ sender: UIButton) {
        performSegue(withIdentifier: "playSegue", sender: self)
//        UINavigationController.pushViewController(UIViewController)
    }
    
    
    @IBAction func showWebKit(_ sender: Any) {
        presenting()
    }
    
    private func presenting() {
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let webKitVC = storyBoard.instantiateViewController(withIdentifier: "WebKit") as! WebKitViewController
       self.present(webKitVC, animated:true, completion:nil)
    }
    
}
