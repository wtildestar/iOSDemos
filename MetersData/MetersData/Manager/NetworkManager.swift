//
//  NetworkManager.swift
//  MetersData
//
//  Created by wtildestar on 14/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared  = NetworkManager()
    let baseURL        = "https://test1.prod2.wellsoft.pro"
    private init() {}
    
    var userResponse: UserResponse?
    
    func sendUser(user: User, completed: @escaping (Result<UserResponse, MDError>) -> Void) {
        let endPoint = baseURL + "/login/enterpassword"

        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUrl))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let parameterDictionary = ["emailOrPhone" : user.emailOrPhone,
                                   "password" : user.password,
                                   "isMobile": "true"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        urlRequest.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let urlResponse = try decoder.decode(UserResponse.self, from: data)
                completed(.success(urlResponse))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
        
    }
    
    func getCounters(completed: @escaping (Result<Data, MDError>) -> Void) {
        let endPoint = baseURL + "/api/Counters/GetList?roomId=5006"
        
        guard let url = URL(string: endPoint), let userResponse = userResponse else {
                completed(.failure(.invalidUrl))
                return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("1", forHTTPHeaderField: "version")
        urlRequest.addValue("Bearer 89dabb6d-bf81-4202-ae39-be0f3830c1db", forHTTPHeaderField: "authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let counters = try decoder.decode(Data.self, from: data)
                completed(.success(counters))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
