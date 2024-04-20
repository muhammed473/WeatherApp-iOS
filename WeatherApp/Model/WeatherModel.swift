//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import Foundation

struct WeatherModel : Codable {
    struct Daily : Codable{
        let date : Date
        let humidity :  Int
        let wind_speed : Double
        
        struct Temp : Codable {
            let minTemp : Double
            let maxTemp : Double
        }
        let temp : Temp
      
        struct Weather : Codable {
            let id : Int
            let main : String
            let weatherIcon : String
        }
        let weather : [Weather]
    }
    let daily  : [Daily]
}
