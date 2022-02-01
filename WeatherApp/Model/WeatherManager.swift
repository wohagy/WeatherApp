//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Полина Шубина on 01.02.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    
    
    let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "63c29d629990918ee2998a644c3d705d"
    var isMetric: Bool
    var units: String {
        return isMetric ? "metric" : "imperial"
    }
    
    func fetchWeather(cityName: String?) {
        guard let city = cityName else {
            return
        }
        let finalURL = openWeatherURL +
                        "appid=" + apiKey +
                        "&units=" + units +
                        "&q=" + city
        
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
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(WeatherData.self, from: weatherData)
            print(getWeatherIconName(for: decoded.weather[0].id))
        } catch {
            print(error)
        }
    }
    
    func getWeatherIconName(for id: Int) -> String{
        switch id {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 801...801:
            return "clouds"
        default:
            return "sun"
        }
    }
}
