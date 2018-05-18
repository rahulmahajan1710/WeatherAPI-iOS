//
//  WeatherInfoViewController.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 18/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import UIKit

class WeatherInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var weatherData : [WeatherData]!
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Info"
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension WeatherInfoViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherDataCell", for: indexPath) as! WeatherDataCell
        let weatherInfo = weatherData[indexPath.row]
        weatherCell.conditionLabel.text = weatherInfo.condition
        weatherCell.minLabel.text = "Min. Temp: \(weatherInfo.minTemperature.format()) \(weatherInfo.unit.rawValue)"
         weatherCell.maxLabel.text = "Max. Temp: \(weatherInfo.maxTemperature.format()) \(weatherInfo.unit.rawValue)"
        weatherCell.dateLabel.text = dateFormatter.string(from: weatherInfo.date)
        return weatherCell
    }
}

extension Float {
    func format() -> String {
        return String(format: "%.2f", self)
    }
}
