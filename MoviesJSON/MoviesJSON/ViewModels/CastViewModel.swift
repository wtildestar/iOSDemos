//
//  CastViewModel.swift
//  MoviesJSON
//
//  Created by wtildestar on 05/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Combine

final class CastViewModel: ObservableObject {
    // input
    @Published var movieId: Int = 642372
    // output
    @Published var casts = [MovieCast]()
    
    init(movieId: Int ) {
        self.movieId = movieId
        $movieId
            .flatMap { (movieId) -> AnyPublisher<[MovieCast], Never> in
                MovieAPI.shared.fetchCredits(for:movieId)
        }
        .assign(to: \.casts, on: self)
        .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}

