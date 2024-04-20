//
//  WeatherCellView.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import UIKit

class WeatherCellView : UITableViewCell {
    
    // MARK: - Properties
    
    let weatherImage : UIImageView = {
       let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    let mainlabel : UILabel =  {
        let label = UILabel()
        label.text = "Rainy"
        return label
    }()
    /* var weatherViewModel : WeatherViewModel {
        didSet{configure()}
    } */
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(weatherImage)
        weatherImage.anchor(top:topAnchor,left: leftAnchor,bottom: bottomAnchor,paddingTop: 7,paddingLeft: 2,paddingBottom: 7)
        addSubview(mainlabel)
        mainlabel.anchor(top: topAnchor,left: weatherImage.rightAnchor,paddingTop: 1,paddingLeft: 2)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
    }
    
}
