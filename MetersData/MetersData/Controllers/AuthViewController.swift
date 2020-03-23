//
//  AuthViewController.swift
//  MetersData
//
//  Created by wtildestar on 15/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var user: User?
    var userResponse: UserResponse?
    
    // MARK: - Methods
    func sendUser() {
        guard let user = user else { return }
        NetworkManager.shared.sendUser(user: user) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userResponse):
                print(userResponse)
                self.userResponse = userResponse
            case .failure(let error):
                print(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        if segue.identifier == "CountersSegue" {
            user = User(emailOrPhone: login, password: password, isMobile: true)
            sendUser()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                UserDefaults.standard.set(self.userResponse!.data, forKey: "token")
            }
        }
    }
}
