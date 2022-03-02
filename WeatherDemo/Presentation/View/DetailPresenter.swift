//
//  DetailPresenter.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation

class DetailPresenter: NSObject {
    var cityLocationModel = CityLocationModel()
    var wetherModel = WeatherModel()
    
    func setUp(info: (CityLocationModel, WeatherModel)) {
        cityLocationModel = info.0
        wetherModel = info.1
    }
}
    
private extension DetailPresenter {
}
