//
//  GHFollowerItemVC.swift
//  GHFollowers
//
//  Created by wtildestar on 19/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class GHFollowerItemVC: GHItemInfoVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
