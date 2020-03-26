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
        
        let defaults = UserDefaults.standard
        let savedToken = defaults.string(forKey: "token")
        
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
    
    func sendCounters(completed: @escaping (MDError?) -> Void) {
        
        
        let url = URL(string: "https://test1.prod2.wellsoft.pro/api/counters/addcountervalues")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let counterNewValue = CounterNewValue(id: 2046, val1Str: "100000.15", val2Str: "0")
        let jsonData = try! JSONEncoder().encode(counterNewValue)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let counterNewValueModel = try JSONDecoder().decode(CounterNewValue.self, from: data)
                print("Response data:\n \(counterNewValueModel.id)")
                print("todoItemModel Title: \(counterNewValueModel.val1Str)")
                print("todoItemModel id: \(counterNewValueModel.val2Str)")
            }catch let jsonErr{
                print(jsonErr)
            }
            
        }
        task.resume()

        
//        let parameters = "{\n    \"Val1Str\": \"95.01\",\n    \"Val2Str\": \"2\",\n    \"Id\": \"2046\"\n}"
//        let postData = parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://test1.prod2.wellsoft.pro/api/Counters/AddCounterValues")!)
//        request.addValue("Bearer 74bd6ace-5e19-48ef-a11a-ae082238a39c", forHTTPHeaderField: "authorization")
//        request.addValue("application/json", forHTTPHeaderField: "content-type")
//        request.addValue("1", forHTTPHeaderField: "version")
//
//        request.httpMethod = "POST"
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print(String(describing: error))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let courses = try decoder.decode([Course].self, from: data)
////                completion(courses)
//            } catch let error {
//                print("Error serialization json", error)
//            }
//
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
        
        
//        let endPoint = baseURL + "api/Counters/AddCounterValues"
//
//        guard let url = URL(string: endPoint) else {
//            completed(.invalidUrl)
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
//
//        let parameterDictionary: [String : Any] = [
//            "id"      : counterNewValue.id,
//            "val1Str" : counterNewValue.val1Str ?? "",
//            "val2Str" : counterNewValue.val2Str ?? ""
//        ]
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
//            return
//        }
//        urlRequest.httpBody = httpBody
//
//        let task = URLSession.shared.dataTask(with: urlRequest) { _, _, error in
//            if let _ = error {
//                completed(.unableToComplete)
//                return
//            }
//        }
//
//        task.resume()
    }
}
