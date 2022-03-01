//
//  WeatherInfoModel.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

struct WeatherInfoModel: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}
