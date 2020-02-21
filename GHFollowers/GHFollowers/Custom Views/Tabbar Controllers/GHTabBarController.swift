//
//  GHTabBarController.swift
//  GHFollowers
//
//  Created by wtildestar on 20/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class GHTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers                 = [createSearchNC(), createFavoriteNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoriteNC() -> UINavigationController {
        let favoriteListVC = FavoritesListVC()
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
