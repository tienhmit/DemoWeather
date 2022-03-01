//
//  WeatherHomeCell.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import UIKit

class WeatherHomeCell: UITableViewCell {
    
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var locationTemperatureLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(info: (CityLocationModel, WeatherModel)) {
        locationNameLabel.text = info.0.name
        countryLabel.text = info.0.country
        locationTemperatureLabel.text = "\(info.1.temperatureInfo.temp)ºF"
    }
}
