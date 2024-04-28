//
//  WeatherCellView.swift
//  WeatherApp
//
//  Created by muhammed dursun on 20.04.2024.
//

import SDWebImage

class WeatherCellView : UITableViewCell {
    
    // MARK: - Properties
    
    var weatherImage : UIImageView = {
       var icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.setDimensions(height: 85, width: 60)
        icon.translatesAutoresizingMaskIntoConstraints = false
       // icon.image = UIImage(named: "pngbulut")
        return icon
    }()
    let mainlabel : UILabel =  {
        let label = UILabel()
        return label
    }()
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "20/04/2024"
        return label
    }()
   //  let minTemp = UILabel()
   // let maxTemp = UILabel()
    let minTemp : UILabel = {
        let label = UILabel()
        label.text = "2"
        return label
    }()
    let maxTemp : UILabel = {
        let label = UILabel()
        label.text = "12"
        return label
    }()
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
   
    var weatherViewModel : WeatherViewModel? {
        didSet{configure()}
    }
    
    // MARK: - Lifecycle
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
         addSubview(weatherImage)
        weatherImage.anchor(top:topAnchor,left: leftAnchor,paddingTop: 6,paddingLeft: 5)
         weatherImage.heightAnchor.constraint(equalToConstant: 85).isActive = true
         addSubview(mainlabel)
         mainlabel.anchor(top: topAnchor,left: weatherImage.rightAnchor,paddingTop: 1,paddingLeft: 2)
         addSubview(dateLabel)
         dateLabel.anchor(top:topAnchor,left:mainlabel.rightAnchor,paddingTop: 1,paddingLeft: 3 )
         
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
    
    func configure() {
        mainlabel.text = weatherViewModel?.main
        wind_speed.text = weatherViewModel?.wind_speed
        dateLabel.text = weatherViewModel?.day
        humidity.text = weatherViewModel?.humidity
        minTemp.text = weatherViewModel?.min
        maxTemp.text = weatherViewModel?.max
        weatherImage.sd_setImage(with: self.weatherViewModel?.weatherIconURL)
     
    }
    
}
