//
//  CityLocationModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 2/28/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct CityLocationModel: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    
    init() {
        name = ""
        latitude = 0
        longitude = 0
        country = ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case latitude = "lat"
        case longitude = "lon"
        case country = "country"
    }
}
