//
//  Constants.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 17/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import Foundation

struct API {
    static let key = "84d25c885c36254000916bbf7058dc65"
    
    static func weatherURLWith(cityName : String, countryCode : String) -> String{
        return "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName),\(countryCode)&mode=json&appid=\(key)"
    }
}
