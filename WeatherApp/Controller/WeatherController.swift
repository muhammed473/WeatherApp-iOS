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
    private var weatherViewModels : [WeatherViewModel] = []
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        getService{print("ViewModel sayısı : \(self.weatherViewModels.count)")}
        
        
        
    }
    
    // MARK: - Assistants
    
    func configureUI() {
        
        tableView.tableHeaderView = weatherHeaderView
        tableView.register(WeatherCellView.self, forCellReuseIdentifier: cellIdentifier)
        weatherHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        /* view.addSubview(humidity)
         humidity.centerX(inView: view)
         humidity.centerY(inView: view) */
        
        tableView.reloadData()
        
    }
    
    func getService(completion:@escaping() ->Void) {
        let serviceApi = ServiceApi.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString("Sivas"){ (placeMarks,error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placeMarks?.first?.location?.coordinate.latitude,
               let lon = placeMarks?.first?.location?.coordinate.longitude{
                serviceApi.getJSON(urlString:  "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=5f5e2e25a9e872e3b2bfe5dbcda29d13",dateDecodingStrategy: .secondsSince1970) { (result: Result<WeatherModel,ServiceApi.APIError>) in
                    switch result {
                    case .success(let weatherModel):
                        DispatchQueue.main.async {
                            self.weatherViewModels = weatherModel.daily.map { WeatherViewModel(daily: $0)}
                          //  self.tableView.reloadData()
                           // completion()
                            self.tableView.reloadData()
                        }
                        completion()
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                       // self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension WeatherController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModels.count
        print(weatherViewModels.count)
        
   
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         /* let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherCellView
          self.weatherViewModels.forEach { weatherViewModel in
          cell.weatherViewModel = weatherViewModel
          }
          return cell */
        
     
        /* let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherCellView
         let weatherViewModel = weatherViewModels[indexPath.row]
         cell.weatherViewModel = weatherViewModel
         return cell */
        
        
        let  everyDayCellWeatherViewModel = weatherViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherCellView
        self.weatherViewModels.forEach { weatherViewModel in
            cell.weatherViewModel = everyDayCellWeatherViewModel
        }
        return cell
        
    }
    
}

// MARK: - UITableViewDelegate

extension WeatherController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}





