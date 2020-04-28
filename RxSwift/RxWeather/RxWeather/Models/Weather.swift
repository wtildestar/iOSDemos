//
//  Weather.swift
//  RxWeather
//
//  Created by wtildestar on 28/04/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct WeatherBody: Decodable {
  let main: Weather
}

extension WeatherBody {
  static var empty: WeatherBody {
    return WeatherBody(main: Weather(temp: 0.0, humidity: 0.0))
  }
}

struct Weather: Decodable {
  let temp: Double
  let humidity: Double
}
