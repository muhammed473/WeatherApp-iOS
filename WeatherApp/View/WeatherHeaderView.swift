//
//  WeatherView.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import UIKit

protocol SearchBarDelegate : AnyObject  {
    func searchBarText(searchBar : UISearchBar)
}

class WeatherHeaderView : UIView {
    
   // MARK: - Properties
    
    private let mySearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "Enter the city name.."
        return searchBar
    }()
    //public var cityText : String?
    weak var delegate : SearchBarDelegate?
   // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(mySearchBar)
        mySearchBar.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 50,paddingLeft: 15,paddingRight: 15)
        mySearchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension WeatherHeaderView: UISearchBarDelegate{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarText(searchBar: searchBar)
    }
    
}
