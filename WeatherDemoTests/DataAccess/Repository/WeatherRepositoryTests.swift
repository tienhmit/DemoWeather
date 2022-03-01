//
//  WeatherRepositoryTests.swift
//  WeatherDemoTests
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class WeatherRepositoryTests: XCTestCase {
    
    var weatherRepository: WeatherRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func setUp() {
        super.setUp()
        weatherRepository = WeatherRepository()
    }
    
    override func tearDown() {
        
    }
    
    func test_fetch() {
        let longitude = 105.841171
        let latidute = 21.0245
        let expected = expectation(description: "Completion handler invoked")
        weatherRepository.fetch(latitude: latidute, longitude: longitude) { weatherModel in
            expected.fulfill()
            XCTAssertNotNil(weatherModel)
        }
        wait(for: [expected], timeout: 30.0)
    }
}
