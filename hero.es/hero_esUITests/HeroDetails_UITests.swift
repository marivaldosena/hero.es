//
//  HeroDetails_UITests.swift
//  hero_esUITests
//
//  Created by Marivaldo Sena on 31/12/20.
//

import XCTest
@testable import hero_es

class HeroDetails_UITests: XCTestCase {
    let app = XCUIApplication()
    var window: UIWindow? = nil

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        XCTAssertEqual(1, 1, "Something went wrong!")
    }
}
