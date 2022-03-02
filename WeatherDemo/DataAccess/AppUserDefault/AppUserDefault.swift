//
//  AppUserDefault.swift
//  WeatherDemo
//
//  Created by Hoang Manh Tien on 2/28/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import Foundation

class AppUserDefault: NSObject {
    private static let isAddedFavouriteKey = "isAddedFavouriteKey"
    
    class func setIsAddedFavourite() {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: isAddedFavouriteKey)
        userDefault.synchronize()
    }
    
    class func isAddedFavourite() -> Bool {
        UserDefaults.standard.bool(forKey: isAddedFavouriteKey)
    }
}
