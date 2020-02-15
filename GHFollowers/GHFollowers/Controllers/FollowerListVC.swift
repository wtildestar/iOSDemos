//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by wtildestar on 14/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Bad stuff happend",
                                                message: error.rawValue,
                                                buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
