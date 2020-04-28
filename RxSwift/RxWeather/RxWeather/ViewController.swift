//
//  ViewController.swift
//  RxWeather
//
//  Created by wtildestar on 28/04/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  @IBOutlet weak var cityNameTextField: UITextField!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.cityNameTextField.rx.value
      .subscribe(onNext: { city in
        if let city = city {
          if city.isEmpty {
            self.dispayWeather(nil)
          } else {
            self.fetchWeather(by: city)
          }
        }
      }).disposed(by: disposeBag)
  }
  
  private func fetchWeather(by city: String) {
    guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
      let url = URL.urlForWeatherAPI(city: cityEncoded) else {
        return
    }
    
    let resource = Resource<WeatherBody>(url: url)
    
    URLRequest.load(resource: resource)
      .observeOn(MainScheduler.instance)
      .catchErrorJustReturn(WeatherBody.empty)
      .subscribe(onNext: { result in
        
        let weather = result.main
        self.dispayWeather(weather)
      }).disposed(by: disposeBag)
  }
  
  private func dispayWeather(_ weather: Weather?) {
    if let weather = weather {
      self.temperatureLabel.text = "\(weather.temp) ℉"
      self.humidityLabel.text = "\(weather.humidity) 💦"
    } else {
      self.temperatureLabel.text = "🙈"
      self.humidityLabel.text = "∅"
    }
  }


}

