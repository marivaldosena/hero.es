//
//  hero_esTests.swift
//  hero.esTests
//
//  Created by Marivaldo Sena on 20/10/20.
//

import XCTest
@testable import hero_es

class hero_esTests: XCTestCase {
    @available(iOS 13.4, macOS 10.15, *)
    func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    @available(iOS 13.4, macOS 10.15, *)
    func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(1 == 1, "Testa se número 1 é igual a 1")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
