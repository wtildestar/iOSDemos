//
//  URLRequest+Ext.swift
//  RxWeather
//
//  Created by wtildestar on 28/04/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Resource<T> {
  let url: URL
}

extension URLRequest {
  static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
    return Observable.from([resource.url])
      .flatMap { url -> Observable<Data> in
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
    }.map { data -> T in
      return try JSONDecoder().decode(T.self, from: data)
    }.asObservable()
  }
}
