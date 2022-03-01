//
//  WindInfoModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct WindInfoModel: Codable {
    let speed: Double
    let deg: Double
    let gust: Double
    
    init() {
        speed = 0
        deg = 0
        gust = 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
}
