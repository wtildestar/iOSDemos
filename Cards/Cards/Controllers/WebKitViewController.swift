//
//  WebKitViewController.swift
//  Cards
//
//  Created by wtildestar on 10/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation
import CoreTelephony

class WebKitViewController: UIViewController, WKUIDelegate, CLLocationManagerDelegate {
    
    var webView: WKWebView!
    var manager: CLLocationManager!
    let preferredLanguage = NSLocale.preferredLanguages[0]
    
    override func loadView() {
        self.view = webView
        let webConfiguration = WKWebViewConfiguration()
        let screenSize: CGRect = UIScreen.main.bounds
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), configuration: webConfiguration)
        webView.uiDelegate = self
        
        view.addSubview(webView)
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
//        setNavigationBar()
        
        let locale = Locale.current
        print(locale.regionCode!)
        configureWebView()
        
        if Locale.current.regionCode == "RU" || preferredLanguage.starts(with: "ru") {
            webView.load("https://yandex.ru/")
        } else {
            webView.load("https://google.com/")
        }
        
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
    
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//        let navItem = UINavigationItem(title: "")
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
//        navItem.rightBarButtonItem = doneItem
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }
//
//    @objc func done() {
//        dismiss(animated: true)
//    }
    
    private func configureWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
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
