//
//  ViewController.swift
//  WeatherApp
//
//  Created by muhammed dursun on 19.04.2024.
//

import UIKit
import CoreLocation

class WeatherController: UITableViewController {
    
    
    // MARK: - Properties
    
    private let weatherHeaderView = WeatherHeaderView()
    private var weatherViewModels : [WeatherViewModel] = []
    private var cityText : String?
    let cellIdentifier = "cell"
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        getService{print("ViewModel sayısı : \(self.weatherViewModels.count)")}
        weatherHeaderView.delegate = self
    }
    
    // MARK: - Assistants
    
    func configureUI() {
        
        tableView.tableHeaderView = weatherHeaderView
        tableView.register(WeatherCellView.self, forCellReuseIdentifier: cellIdentifier)
        weatherHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        tableView.reloadData()
    }
    
    func getService(completion:@escaping() ->Void) {
        let serviceApi = ServiceApi.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        //CLGeocoder().geocodeAddressString("Sivas"){ (placeMarks,error) in
        guard let cityText = cityText else {return}
        CLGeocoder().geocodeAddressString(cityText){ (placeMarks,error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placeMarks?.first?.location?.coordinate.latitude,
               let lon = placeMarks?.first?.location?.coordinate.longitude{
                serviceApi.getJSON(urlString:  "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=5f5e2e25a9e872e3b2bfe5dbcda29d13",dateDecodingStrategy: .secondsSince1970) { (result: Result<WeatherModel,ServiceApi.APIError>) in
                    switch result {
                    case .success(let weatherModel):
                        DispatchQueue.main.async { [weak self] in
                            self?.weatherViewModels = weatherModel.daily.map { WeatherViewModel(daily: $0)}
                            self?.tableView.reloadData()
                        }
                        completion()
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension WeatherController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        return 140
    }
    
}

// MARK: - SearchBarDelegate

extension WeatherController : SearchBarDelegate{
    
    func searchBarText(searchBar: UISearchBar) {
        print("Tıkladım")
        guard let text = searchBar.text,!text.replacingOccurrences(of: " ", with: "").isEmpty else{return}
        searchBar.resignFirstResponder()
        self.cityText = text
        getService {  
            print("city : \(self.cityText!)")
        }
    }
    
}




