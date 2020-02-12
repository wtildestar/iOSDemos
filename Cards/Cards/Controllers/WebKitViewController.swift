//
//  WebKitViewController.swift
//  Cards
//
//  Created by wtildestar on 10/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets

    @IBOutlet var webView: UIWebView!
    
    // MARK: - Actions
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.com")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies({ (cookies) in
                print(cookies)
            })
        } else {
            guard let cookies = HTTPCookieStorage.shared.cookies else {
                return
            }
            print(cookies)
        }
    }
    
    
    // MARK: - Methods
    
    public static func storyboardInstance() -> WebKitViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "WebKit") as? WebKitViewController
    }
    
}
    
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
