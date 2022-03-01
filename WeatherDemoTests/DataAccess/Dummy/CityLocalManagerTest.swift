//
//  CityLocalManagerTests.swift
//  WeatherDemoTests
//
//  Created by Hoang Manh Tien on 2/28/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class CityLocalManagerTests: XCTestCase {

    var cityLocalManager: CityLocalManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        cityLocalManager = CityLocalManager.shared
    }
    
    func test_fetchOne() throws {
        let result = try cityLocalManager.fetchOne(by: "1559970")
        XCTAssertEqual(result?.id, "1559970")
    }
    
    func test_fetchAll() throws {
        let result = try cityLocalManager.fetchAll()
        XCTAssertFalse(result.isEmpty)
    }
}
