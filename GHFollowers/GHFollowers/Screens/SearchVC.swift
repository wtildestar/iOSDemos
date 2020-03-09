//
//  SearchVC.swift
//  GHFollowers
//
//  Created by wtildestar on 13/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    let logoImageView = UIImageView()
    let usernameTextField = GHTextField()
    let callToActionButton = GHButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    var usernameTextFieldCenterConstraint: Constraint? = nil
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // .systemBackground for light/dark mode
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        // hide navbar at main controller with tabbar when click back on detail controller
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.usernameTextFieldCenterConstraint?.update(offset: -view.bounds.width)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogo()
        animateUsernameTextField()
        animateCallToActionButton()
    }
    
    // MARK: - Methods
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            callToActionButton.shake()
            presentGHAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for 😱", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    private func animateLogo() {
        let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                .repeat,
                                                .autoreverse]
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.5,
                       options: options,
                       animations: { [weak self] in
                        self?.logoImageView.bounds.size.width *= 1.10
                        self?.logoImageView.bounds.size.height *= 1.10
        })
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.3,
                       options: [],
                       animations: { [weak self] in
                        self?.logoImageView.alpha = 1
        })
    }
    
    private func animateUsernameTextField() {
        self.usernameTextFieldCenterConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          })
    }
    
    private func animateCallToActionButton() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
                        self?.callToActionButton.alpha = 1
          })
    }
    
    // MARK: - Autolayout
    
    private func configureLogoImageView() {
        logoImageView.image = Images.ghLogo
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageView.alpha = 0
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(topConstraintConstant)
            make.centerX.equalTo(view.snp.centerX)
            make.height.width.equalTo(200)
        }
    }
    
    private func configureTextField() {
        usernameTextField.delegate = self
        usernameTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(callToActionButton.snp.top).offset(-10)
            make.height.equalTo(50)
            self.usernameTextFieldCenterConstraint = make.centerX.equalTo(view).constraint
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
    }
    
    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        callToActionButton.alpha = 0
        callToActionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.centerX.equalTo(view)
            make.size.greaterThanOrEqualTo(CGSize(width: 200, height: 50))
        }
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
