//
//  AuthViewController.swift
//  MetersData
//
//  Created by wtildestar on 15/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func sendUser() {
        guard let user = user else { return }
        NetworkManager.shared.sendUser(user: user) { result in

            switch result {
            case .success(let userResponse):
                print(userResponse)
//                userResponse(result)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        user = User(emailOrPhone: login, password: password, isMobile: true)
        sendUser()
        
        let CountersVC = CountersViewController()
        navigationController?.pushViewController(CountersVC, animated: true)
    }

}
