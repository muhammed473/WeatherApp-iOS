//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import Foundation


public struct WeatherModel : Codable {
    
    struct Daily : Codable{
        let dt : Date
        let humidity :  Int
        let wind_speed : Double
        
        struct Temp : Codable {
            let min : Double
            let max : Double
        }
        let temp : Temp
      
        struct Weather : Codable {
            let id : Int
            let main : String
            let icon : String
        }
        let weather : [Weather]
    }
    
    var daily  : [Daily]
    
}




