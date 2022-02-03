//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Полина Шубина on 01.02.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import CoreLocation
import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(weather: WeatherModel)
}
  

struct WeatherManager {
    
    let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "63c29d629990918ee2998a644c3d705d"
    var isMetric: Bool
    var units: String {
        return isMetric ? "metric" : "imperial"
    }
    
    var delegate: WeatherDelegate?
    
    func fetchWeather(cityName: String?) {
        guard let city = cityName else {return}
        let finalURL = openWeatherURL +
            "appid=" + apiKey +
            "&units=" + units +
            "&q=" + city
        performRequest(with: finalURL)
    }
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        let finalURL = openWeatherURL +
            "appid=" + apiKey + "&lat=\(latitude)" + "&lon=\(longitude)" + "&units=" + units
        performRequest(with: finalURL)
    }

    
    func performRequest(with urlStrig: String) {
        if let url = URL(string: urlStrig) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoded.weather[0].id
            let temperature = decoded.main.temp
            let name = decoded.name
            let weather = WeatherModel(conditionID: id, cintyName: name, temperature: temperature)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
}
