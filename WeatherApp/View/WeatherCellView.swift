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
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "20/04/2024"
        return label
    }()
    let minTemp = UILabel()
    let maxTemp = UILabel()
    var tempStack = UIStackView()
    let humidity : UILabel = {
        let label = UILabel()
        label.text = "Nem : 53"
        return label
    }()
    let wind_speed : UILabel = {
        let label = UILabel()
        label.text = "Rüzgar hızı : 6.33"
        return label
    }()
    var weatherViewModel : WeatherViewModel! {
        didSet{configure()}
    }
    
    // MARK: - Lifecycle
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(weatherImage)
        weatherImage.anchor(top:topAnchor,left: leftAnchor,bottom: bottomAnchor,paddingTop: 7,paddingLeft: 2,paddingBottom: 7)
        addSubview(mainlabel)
        mainlabel.anchor(top: topAnchor,left: weatherImage.rightAnchor,paddingTop: 1,paddingLeft: 2)
        addSubview(dateLabel)
        dateLabel.anchor(top:topAnchor,left:mainlabel.rightAnchor,paddingTop: 1,paddingLeft: 3 )
        
        minTemp.text = "Minimum 10"
        maxTemp.text = "20"
        tempStack = UIStackView(arrangedSubviews: [minTemp,maxTemp])
        tempStack.axis = .vertical
        tempStack.spacing = 5
        addSubview(tempStack)
        tempStack.anchor(top:mainlabel.bottomAnchor,left:weatherImage.rightAnchor,paddingTop: 5,paddingLeft: 2)
        
        addSubview(humidity)
        humidity.anchor(top:dateLabel.bottomAnchor,left: minTemp.rightAnchor,paddingTop: 5,paddingLeft: 2)
        
        addSubview(wind_speed)
        wind_speed.anchor(top:humidity.bottomAnchor,left:maxTemp.rightAnchor,paddingTop: 5,paddingLeft: 2)
               
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        weatherImage.image = UIImage(named: "bulut")
        mainlabel.text = weatherViewModel.value
        dateLabel.text = weatherViewModel.value
        minTemp.text = weatherViewModel.value
        maxTemp.text = weatherViewModel.value
        humidity.text = weatherViewModel.value
        wind_speed.text = weatherViewModel.value
    }
    
   
    
}
