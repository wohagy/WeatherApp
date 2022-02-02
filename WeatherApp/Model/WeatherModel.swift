//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Полина Шубина on 02.02.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cintyName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", round(temperature))
    }
    var conditionName: String {
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    

}
