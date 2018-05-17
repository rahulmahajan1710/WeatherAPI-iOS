//
//  ViewController.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 17/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NetworkManager.shared.fetchWeatherForecastData(city: "Pune", countryCode: "In") { (data, error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

