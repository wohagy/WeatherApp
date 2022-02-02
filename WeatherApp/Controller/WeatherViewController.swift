//
//  ViewController.swift
//  WeatherApp
//
//  Created by wohagy on 29.01.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherDelegate, CLLocationManagerDelegate{
    
    private var manager = WeatherManager(isMetric: true)
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityTextFiled: UITextField!
    @IBAction func searchButtonAction(_ sender: UIButton) {
        manager.fetchWeather(cityName: cityTextFiled.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextFiled.delegate = self
        manager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        manager.fetchWeather(cityName: cityTextFiled.text)
        return true
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cintyName
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Hello locations")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

