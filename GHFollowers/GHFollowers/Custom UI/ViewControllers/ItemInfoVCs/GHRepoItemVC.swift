//
//  GHRepoItemVC.swift
//  GHFollowers
//
//  Created by wtildestar on 19/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class GHRepoItemVC: GHItemInfoVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
