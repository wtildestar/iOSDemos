//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by wtildestar on 18/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GHDataLoadingVC {
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GHBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GHRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GHFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertMonthYearFormat())"
    }
    
    func layoutUI() {
        let padding: CGFloat     = 20
        let itemHeight: CGFloat  = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: GHRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }

        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GHFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGHAlertOnMainThread(title: "No followers", message: "This user has no followers😕", buttonTitle: "So sad")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}

