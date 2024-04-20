//
//  WeatherView.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import UIKit

class WeatherHeaderView : UIView {
    
   // MARK: - Properties
    
    private let mySearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "Enter the city name.."
        return searchBar
    }()
    
   // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .red
        addSubview(mySearchBar)
        mySearchBar.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 50,paddingLeft: 15,paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
