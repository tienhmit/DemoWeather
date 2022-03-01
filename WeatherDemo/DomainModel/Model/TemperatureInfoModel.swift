//
//  TemperatureInfoModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct TemperatureInfoModel: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
    let sea_level: Double
    let grnd_level: Double
    
    init() {
        temp = 0
        feels_like = 0
        temp_min = 0
        temp_max = 0
        pressure = 0
        humidity = 0
        sea_level = 0
        grnd_level = 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
}
