//
//  URL+Ext.swift
//  RxWeather
//
//  Created by wtildestar on 28/04/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

extension URL {
  static func urlForWeatherAPI(city: String) -> URL? {
    return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=8f2fd02d844675662f9c62aa3c402b38")
  }
}
