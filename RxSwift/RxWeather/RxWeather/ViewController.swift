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
    
    takeValueFromTextField()
  }
  
  private func takeValueFromTextField () {
    self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
      .asObservable()
      .map { self.cityNameTextField.text }
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
    
    let search = URLRequest.load(resource: resource)
    .observeOn(MainScheduler.instance) // Main Thread
    .catchError { error in
      print(error.localizedDescription)
      return Observable.just(WeatherBody.empty)
    }.asDriver(onErrorJustReturn: WeatherBody.empty)
    
    search.map { "\($0.main.temp) ℉" }
    .drive(self.temperatureLabel.rx.text)
    .disposed(by: disposeBag)
  
    search.map { "\($0.main.humidity) 💦" }
    .drive(self.humidityLabel.rx.text)
    .disposed(by: disposeBag)
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

