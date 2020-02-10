//
//  WebKitViewController.swift
//  Cards
//
//  Created by wtildestar on 10/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var webView: WKWebView!
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var webKitURL: String? = "https://google.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard
            let webKitURL = webKitURL,
            let url = URL(string: webKitURL)
            else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
