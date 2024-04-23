//
//  ViewController.swift
//  WeatherApp
//
//  Created by muhammed dursun on 19.04.2024.
//

import UIKit
import SDWebImage
import CoreLocation

let cellIdentifier = "cell"
class WeatherController: UITableViewController {

    // MARK: - Properties
     
    private let weatherHeaderView = WeatherHeaderView()
    private var weatherModel : WeatherModel?
    
    let humidity : UILabel = {
        let label = UILabel()
        return label
    }()
     
    // MARK: - Lifecycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    
        view.addSubview(humidity)
        humidity.centerX(inView: view)
        humidity.centerY(inView: view)
        
        let serviceApi = ServiceApi.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString("Kayseri"){ (placeMarks,error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placeMarks?.first?.location?.coordinate.latitude,
               let lon = placeMarks?.first?.location?.coordinate.longitude{
                serviceApi.getJSON(urlString:  "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=5f5e2e25a9e872e3b2bfe5dbcda29d13",dateDecodingStrategy: .secondsSince1970) { (result: Result<WeatherModel,ServiceApi.APIError>) in
                    switch result {
                    case .success(let weatherModel):
                        for daily  in weatherModel.daily{
                            print(" PRİNT : DAİLY / Humidity :  \(daily.humidity) ")
                            print(" PRİNT : DAİLY / Date :  \(dateFormatter.string(from: daily.dt)) ")
                            print(" PRİNT : DAİLY / MAX TEMP : \(daily.temp.max)")
                            print(" PRİNT : DAİLY / MİN TEMP : \(daily.temp.min)")
                            print(" PRİNT : DAİLY / MAİN : \(daily.weather[0].main)")
                            print(" PRİNT : DAİLY / WEATHER/İCON : \(daily.weather[0].weatherIconURL) ")
                            DispatchQueue.main.async {
                                self.humidity.text = String(daily.humidity)
                            }
                            self.weatherModel = weatherModel
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }
          
    }
    
    func configureUI() {
        
        tableView.tableHeaderView = weatherHeaderView
        tableView.register(WeatherCellView.self, forCellReuseIdentifier: cellIdentifier)
        weatherHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
    }
    
}

// MARK: - UITableViewDataSource

extension WeatherController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherCellView
      
        return cell
        
    }
    
}

// MARK: - UITableViewDelegate

extension WeatherController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}



