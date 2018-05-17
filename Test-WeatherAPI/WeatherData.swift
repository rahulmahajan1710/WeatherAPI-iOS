//
//  WeatherData.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 17/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import Foundation
public struct APIQuery : Hashable{
    public var hashValue: Int{
        return cityName.hashValue
    }
    
    public static func ==(lhs: APIQuery, rhs: APIQuery) -> Bool {
        return lhs.cityName == rhs.cityName && lhs.countryCode == rhs.countryCode
    }
    
    let cityName : String
    let countryCode : String
    
    
}

public struct WeatherData {
    var minTemperature: Float
    var maxTemperature: Float
    var condition: String
    var date : Date
    var unit: TemperatureUnit
}

public enum TemperatureUnit: String {
    case scientific = "K"
    case metric = "C"
    case imperial = "F"
}
