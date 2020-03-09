//
//  GHRepoItemVC.swift
//  GHFollowers
//
//  Created by wtildestar on 19/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

protocol GHRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GHRepoItemVC: GHItemInfoVC
{
    
    weak var delegate: GHRepoItemVCDelegate!
    
    init(user: User, delegate: GHRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: UIColor(red: 36.0/255.0, green: 41.0/255.0, blue: 46.0/255.0, alpha: 1.0), title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
