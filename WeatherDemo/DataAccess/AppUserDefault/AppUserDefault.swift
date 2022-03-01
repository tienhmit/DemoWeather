//
//  AppUserDefault.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 2/28/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation

class AppUserDefault: NSObject {
    private static let isAddedCityLocationCoreDataKey = "isAddedCityLocationCoreDataKey"
    
    class func setIsDummyCityLocation() {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: isAddedCityLocationCoreDataKey)
        userDefault.synchronize()
    }
    
    class func isAddedCityLocationCoreData() -> Bool {
        UserDefaults.standard.bool(forKey: isAddedCityLocationCoreDataKey)
    }
}
