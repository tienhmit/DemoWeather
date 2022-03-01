//
//  BaseFetcherTests.swift
//  WeatherDemoTests
//
//  Created by Hoang Manh Tien on 3/1/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class BaseFetcherTests: XCTestCase {
    
    var baseFetcher: BaseFetcher!
    
    override func setUp() {
        baseFetcher = BaseFetcher.shared
    }
    
    override func tearDown() {
        
    }
    
    func test_fetch() {
        /*
         London location
         lat 51.5156177
         lon -0.0919983
        */
        let request = WeatherRequestConditionsType.byLocation(51.5156177, -0.0919983)
        let expected = expectation(description: "Completion handler invoked")
        baseFetcher.startFetch(requestConditions: request,
                               complete: { data in
                                expected.fulfill()
                                XCTAssertNotNil(data)},
                               failure: { error in
                                expected.fulfill()
                                XCTFail()})
        wait(for: [expected], timeout: 30.0)
    }
}
