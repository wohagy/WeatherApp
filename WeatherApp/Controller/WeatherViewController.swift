//
//  ViewController.swift
//  WeatherApp
//
//  Created by wohagy on 29.01.2022.
//  Copyright © 2022 wohagy. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate{
    
    private var manager = WeatherManager(isMetric: true)
    
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        manager.fetchWeather(cityName: cityTextFiled.text)
        return true
    }

}

