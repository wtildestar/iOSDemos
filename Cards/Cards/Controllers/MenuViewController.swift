//
//  MenuViewController.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var webKitURL: String?
    
    @IBAction func playButton(_ sender: UIButton) {
        performSegue(withIdentifier: "playSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let webKitViewController = segue.destination as! WebKitViewController
//////        WebKitViewController.navigationTitle.title = courseName
////
////        if let url = webKitURL {
////            webKitViewController.webKitURL = url
////        }
//    }

}
