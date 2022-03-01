//
//  CoordinateInfoModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct CoordinateInfoModel: Codable {
    let latitude: Double
    let longitude: Double
    
    init() {
        latitude = 0
        longitude = 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
