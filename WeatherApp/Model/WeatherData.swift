//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Полина Шубина on 01.02.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import Foundation

struct  WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
