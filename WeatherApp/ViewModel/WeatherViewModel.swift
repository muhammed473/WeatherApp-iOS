//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import UIKit


struct WeatherViewModel {
    
    private let weatherModel : WeatherModel
  
    
    var value : String?
    
    
    init(weatherModel : WeatherModel) {
        self.weatherModel = weatherModel
       
    }
    
    
}

