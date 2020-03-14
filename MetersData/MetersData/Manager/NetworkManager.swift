//
//  NetworkManager.swift
//  MetersData
//
//  Created by wtildestar on 14/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

class NetworkManager {
    private let shared = NetworkManager()
    let baseURL        = "https://test1.prod2.wellsoft.pro/"
    private init() {}
    
    func authUser(_ sender: Any) {
        let Url = baseURL + "/login/enterpassword"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["emailOrPhone" : "9527400031", "password" : "1", "isMobile" : "true"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
