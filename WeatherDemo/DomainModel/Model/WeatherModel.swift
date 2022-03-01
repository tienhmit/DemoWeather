//
//  WeatherModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct WeatherModel: Codable {
    let coordinateInfoModel: CoordinateInfoModel
    let weatherInfoModel: [WeatherInfoModel]
    let temperatureInfo: TemperatureInfoModel
    let windInfoModel: WindInfoModel
    
    init() {
        coordinateInfoModel = CoordinateInfoModel()
        weatherInfoModel = [WeatherInfoModel]()
        temperatureInfo = TemperatureInfoModel()
        windInfoModel = WindInfoModel()
    }
    
    private enum CodingKeys: String, CodingKey {
        case coordinateInfoModel = "coord"
        case weatherInfoModel = "weather"
        case temperatureInfo = "main"
        case windInfoModel = "wind"
    }
}
