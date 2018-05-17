//
//  CitiesTableViewController.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 18/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CitiesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select City"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = CLLocationDistance(1000.0)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension CitiesTableViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let city = DataManager.shared.cities[indexPath.row]
        cell.textLabel?.text = "\(city.cityName), \(city.countryCode)"
        return cell
    }
}

extension CitiesTableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city =  DataManager.shared.cities[indexPath.row]
        NetworkManager.shared.fetchWeatherForecastData(city: city.cityName, countryCode: city.countryCode) { (weatherData, error) in
            if let data = weatherData{
                let sorted = data.sorted(by: { (d1, d2) -> Bool in
                    return d1.date.compare(d2.date) == .orderedDescending
                })
                
                if let weatherInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherInfoViewController") as? WeatherInfoViewController{
                    DispatchQueue.main.async {
                        weatherInfoVC.weatherData = sorted
                        self.navigationController?.pushViewController(weatherInfoVC, animated: true)
                    }
                   
                }
            }
        }
    }
}


extension CitiesTableViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, currentLocation == nil{
            currentLocation = location
            locationManager.stopUpdatingLocation()
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location,completionHandler: { (placemarks, error) in
                if error == nil,
                    let placemark = placemarks?[0],
                    let city = placemark.locality,
                    let countryCode = placemark.isoCountryCode{
                    let currentLocation = APIQuery(cityName: city, countryCode: countryCode)
                    DataManager.shared.cities.append(currentLocation)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
