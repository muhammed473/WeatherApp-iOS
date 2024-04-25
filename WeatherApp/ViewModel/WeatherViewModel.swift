//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import UIKit


struct WeatherViewModel {
    
    var daily : WeatherModel.Daily
    
  
    private static var dateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E,MMM,d"
        return dateFormatter
    }
    
    private static var numberFormatter : NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2 : NumberFormatter {
        let numberFormatter2 = NumberFormatter()
        numberFormatter2.numberStyle = .percent // 0.12 = %12
        return numberFormatter2
    }
    
    var day : String {
        return Self.dateFormatter.string(from: daily.dt)
    }
    var humidity : String{
        return " 🪼 Humidity: \(daily.humidity)%"
    }
    var wind_speed : String{
        return " \(Self.numberFormatter2.string(from: daily.wind_speed as NSNumber) ?? "0%")"
    }
    var max : String{
        return "High: \(Self.numberFormatter.string(from: daily.temp.max as NSNumber) ?? "0")°"
    }
    var min : String{
        return "Low: \(Self.numberFormatter.string(from: daily.temp.min as NSNumber) ?? "0")°"
    }
    var main : String{
        daily.weather[0].main.capitalized
    }
   
   
    
}

