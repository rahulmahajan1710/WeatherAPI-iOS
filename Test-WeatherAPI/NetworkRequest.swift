//
//  NetworkRequest.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 17/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case post = "POST"
    case get  = "GET"
}

protocol NetworkRequest {
    var url : String { get }
    var method : HTTPMethod { get }
}
