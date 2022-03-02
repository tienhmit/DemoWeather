//
//  BaseCoreDataTests.swift
//  WeatherDemoTests
//
//  Created by Hoang Manh Tien on 3/2/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class BaseCoreDataTests: XCTestCase {
    
    var baseCoreData: BaseCoreDataInterface!

    override func setUp() {
        baseCoreData = BaseCoreData()
    }
    
    override class func tearDown() {
        
    }
    
    func test_insert() throws {
        try baseCoreData.delete(modelType: CityLocationModel.self)
        let model1 = CityLocationModel()
        let model2 = CityLocationModel()
        let cityModelCoreDatalConditionType = CityLocationModelCoreDataConditionType.all
        
        try baseCoreData.insert(models: [model1, model2])
        
        let result: [CityLocationModel] = try baseCoreData.fetch(conditions: cityModelCoreDatalConditionType)
        
        XCTAssertEqual(result.count, 2)
    }
    
    func test_delete() throws {
        try baseCoreData.delete(modelType: CityLocationModel.self)
        let model1 = CityLocationModel()
        let model2 = CityLocationModel()
        let cityModelCoreDatalConditionType = CityLocationModelCoreDataConditionType.all
        
        try baseCoreData.insert(models: [model1, model2])
        
        try baseCoreData.delete(models: [model2])
        
        let result: [CityLocationModel] = try baseCoreData.fetch(conditions: cityModelCoreDatalConditionType)
        
        XCTAssertEqual(result.count, 1)
    }
}
