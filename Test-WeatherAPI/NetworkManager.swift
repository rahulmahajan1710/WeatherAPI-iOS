//
//  NetworkManager.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 17/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import Foundation

enum NetworkError : Error{
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    let urlSession = URLSession.shared
    
    func fetchWeatherForecastData(city: String, countryCode: String, completionHandler: @escaping ([WeatherData]?, NetworkError?) -> Void) {
        
        let endpoint = API.weatherURLWith(cityName: city, countryCode: countryCode)
        
        let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let endpointURL = URL(string: safeURLString) else {
            completionHandler(nil, NetworkError.invalidURL(safeURLString))
            return
        }
        
        let dataTask = urlSession.dataTask(with: endpointURL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                completionHandler(nil, NetworkError.forwarded(error!))
                return
            }
            guard let responseData = data else {
                completionHandler(nil, NetworkError.invalidPayload(endpointURL))
                return
            }
            self.decode(jsonData: responseData, endpointURL: endpointURL, completionHandler: completionHandler)
        })
        dataTask.resume()
    }
    
     private func decode(jsonData: Data, endpointURL: URL, completionHandler: @escaping ([WeatherData]?, NetworkError?) -> Void){
        do{
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]{
                completionHandler(self.weatherDataFrom(json: jsonObject) , nil)
            }
            else{
                completionHandler(nil , NetworkError.invalidPayload(endpointURL))
            }
        }
        catch let error{
            completionHandler(nil, NetworkError.forwarded(error))
        }
    }
    
    func weatherDataFrom(json : [String:Any]) -> [WeatherData]{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        var weatherForecast = [WeatherData]()
        if let list = json["list"] as? [[String:Any]]{
            for info in list{
                if let main = info["main"] as? [String:Any],
                    let tempMin = main["temp_min"] as? NSNumber,
                    let tempMax = main["temp_max"] as? NSNumber,
                    let weather = info["weather"] as? [[String:Any]],
                    let desc = weather.first?["description"] as? String,
                    let dateText = info["dt_txt"] as? String,
                    let date = dateformatter.date(from: dateText){
                    
                    let data = WeatherData(minTemperature: tempMin.floatValue, maxTemperature: tempMax.floatValue, condition: desc, date: date, unit: .scientific)
                    weatherForecast.append(data)
                }
            }
        }
        return weatherForecast
    }
    
}
