//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Полина Шубина on 01.02.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import Foundation

struct  WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
}
