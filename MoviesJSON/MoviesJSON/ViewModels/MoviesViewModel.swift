//
//  MoviesViewModel.swift
//  MoviesJSON
//
//  Created by wtildestar on 05/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Combine

final class MoviesViewModel: ObservableObject {
    // input
    @Published var indexEndpoint: Int = 2
    // output
    @Published var movies = [Movie]()
    
    init() {
          $indexEndpoint
           .flatMap { (indexEndpoint) -> AnyPublisher<[Movie], Never> in
                MovieAPI.shared.fetchMovies(from:
                                    Endpoint( index: indexEndpoint)!)
           }
         .assign(to: \.movies, on: self)
         .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
