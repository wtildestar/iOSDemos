//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by wtildestar on 13/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView             = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    func getFavorites() {
        PersistenceManager.retreiveFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                break
            }
        }
    }

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
}
