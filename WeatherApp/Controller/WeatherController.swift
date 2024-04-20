//
//  ViewController.swift
//  WeatherApp
//
//  Created by muhammed dursun on 19.04.2024.
//

import UIKit
import SDWebImage

let cellIdentifier = "cell"
class WeatherController: UITableViewController {

    // MARK: - Properties
     
    private let weatherHeaderView = WeatherHeaderView()
     
    // MARK: - Lifecycle
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
        
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
         return 7
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



