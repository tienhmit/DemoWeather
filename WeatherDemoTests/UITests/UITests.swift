//
//  UITests.swift
//  WeatherDemoTests
//
//  Created by Hoang Manh Tien on 3/3/22.
//  Copyright © 2022 Hoang Manh Tien. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import WeatherDemo

class UITests: XCTestCase {
    
    var homeViewController: WeatherHomeViewController!
    var detailViewController: DetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let stroryboard1 = UIStoryboard(name: "WeatherHome", bundle: nil)
        homeViewController = stroryboard1.instantiateInitialViewController() as? WeatherHomeViewController
        let stroryboard2 = UIStoryboard(name: "Detail", bundle: nil)
        detailViewController = stroryboard2.instantiateInitialViewController() as? DetailViewController
        let info = (CityLocationModel(), WeatherModel())
        detailViewController.setUp(info: info)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homeViewController = nil
        detailViewController = nil
    }
    
    func test_homeViewController() throws {
        assertSnapshot(matching: homeViewController, as: .image)
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhoneXr))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPhoneSe))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPadMini))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPadPro10_5))
        assertSnapshot(matching: homeViewController, as: .image(on: .iPadPro12_9))
    }
    
    func test_detailViewController() throws {
        assertSnapshot(matching: detailViewController, as: .image)
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhoneXr))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPhoneSe))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPadMini))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPadPro10_5))
        assertSnapshot(matching: detailViewController, as: .image(on: .iPadPro12_9))
    }
}
