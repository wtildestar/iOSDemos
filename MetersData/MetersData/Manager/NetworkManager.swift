//
//  NetworkManager.swift
//  MetersData
//
//  Created by wtildestar on 14/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared  = NetworkManager()
    let baseURL        = "https://test1.prod2.wellsoft.pro/"
    let cache          = NSCache<NSString, UIImage>()
    let savedToken = UserDefaults.standard.string(forKey: "token")
    private init() {}
    
    func sendUser(user: User, completed: @escaping (Result<UserResponse, MDError>) -> Void) {
        let endPoint = baseURL + "login/enterpassword"

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
        let endPoint = baseURL + "api/Counters/GetList?roomId=5006"
        
        guard let url = URL(string: endPoint) else {
                completed(.failure(.invalidUrl))
                return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("1", forHTTPHeaderField: "version")
        urlRequest.addValue(("\(savedToken!)"), forHTTPHeaderField: "authorization")
//        urlRequest.addValue("Bearer 89dabb6d-bf81-4202-ae39-be0f3830c1db", forHTTPHeaderField: "authorization")
        
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
                print("Invalid token data save", error)
            }
        }

        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    func convertArray(counterNewValue: [CounterNewValue]) -> String {
        var parameters = ""
        var comma = ",\n"
        for (index, counter) in counterNewValue.enumerated() {
            if index == counterNewValue.count - 1 {
                comma = ""
            }
            parameters += "{\n        \"val1Str\": \"\(counter.val1Str)\",\n        \"val2Str\": \"\(counter.val2Str)\",\n        \"id\": \"\(counter.id)\"\n    }\(comma)"
        }
        print(parameters)
        return parameters
    }
    
    func sendCounters(counterNewValue: [CounterNewValue], completed: @escaping (MDError?) -> Void) {
        
        let endPoint = baseURL + "api/Counters/AddCounterValues"
        
        guard let url = URL(string: endPoint) else {
            print(MDError.invalidUrl)
            return
        }
        
        let convertingParams = convertArray(counterNewValue: counterNewValue)
        
            let parameters = "[\n \(convertingParams) \n]"
            print(parameters)
            
            let postData = parameters.data(using: .utf8)
            
            var request = URLRequest(url: url)
            request.addValue(("\(savedToken!)"), forHTTPHeaderField: "authorization")
            request.addValue("1", forHTTPHeaderField: "version")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = postData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
            }
            
            task.resume()
    }
}
