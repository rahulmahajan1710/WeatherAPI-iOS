//
//  DataManager.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 18/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import Foundation


class DataManager: NSObject {
    static let shared = DataManager()
    lazy var cities : [APIQuery] = {
        let pune = APIQuery(cityName: "Pune", countryCode: "IN")
        let mumbai = APIQuery(cityName: "Mumbai", countryCode: "IN")
        let delhi = APIQuery(cityName: "Delhi", countryCode: "IN")
        let cupertino = APIQuery(cityName: "Cupertino", countryCode: "US")
        let london = APIQuery(cityName: "London", countryCode: "UK")
        return  [pune,mumbai,delhi,cupertino,london]
    }()
    
    private override init() {
    }
    
    
    
}
