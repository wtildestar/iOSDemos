//
//  MovieRepository.swift
//  MovieKit
//
//  Created by Alfian Losari on 11/24/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Foundation
import Combine

public class MovieStore: MovieService {
    
    public static let shared = MovieStore()
    private init() {}
    private let apiKey = "90c214bd80b50773a0be627863a8c841"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    // запоминание подписки subscription в свойстве Set<AnyCancellable> для метода store функции fetchMovies
    private var subscriptions = Set<AnyCancellable>()
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    
    func fetchMovies(from endpoint: Endpoint) -> Future<[Movie], MovieStoreAPIError> {
        return Future<[Movie], MovieStoreAPIError> {
            [unowned self] promise in
            guard let url = self.generateURL(with: endpoint) else {
                return
                    promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
            
            // реализую urlSession для выборки фильмов
            self.urlSession.dataTaskPublisher(for: url)
                // реализую tryMap оператор в цепочке "издателей"
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                        200...299 ~= httpResponse.statusCode else {
                            throw MovieStoreAPIError.responseError(
                                (response as? HTTPURLResponse)?.statusCode ?? 500
                            )
                    }
                    return data
            }
            // декодирование данных в Модель
            .decode(type: MoviesResponse.self, decoder: self.jsonDecoder)
            // main thread / позволит подписчику получить значение value на main потоке
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    switch error {
                    case let urlError as URLError:
                        promise(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        promise(.failure(.decodingError(decodingError)))
                    case let apiError as MovieStoreAPIError:
                        promise(.failure(apiError))
                    default:
                        promise(.failure(.genericError))
                    }
                }
            }, receiveValue: { promise(.success($0.results)) })
            // после того как функция fetchMovies завершит свою работу применяю метод store который обеспечит работоспособность подписки тк subscription является Cancellable
            .store(in: &self.subscriptions)
        }
    }
    
    private func generateURL(with endpoint: Endpoint) -> URL? {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            return nil
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

}
