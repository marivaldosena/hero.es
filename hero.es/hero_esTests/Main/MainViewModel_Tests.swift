//
//  MainViewModel_Tests.swift
//  hero_esTests
//
//  Created by Marivaldo Sena on 04/01/21.
//

import XCTest
@testable import hero_es

class MainViewModel_Tests: XCTestCase {
    private var service: MainServiceProtocol = MockMainService()
    private var viewModel: MainViewModel? = nil

    override func setUp() {
        service = MockMainService()
        viewModel = MainViewModel(with: service)
    }

    override func tearDown() {
        viewModel = nil
    }

    func testLoginButtonTitle() {
        let buttonTitle = "Login"
        let fromViewModel = viewModel?.getString(for: .loginButtonTitle) ?? ""
        viewModel?.getString(for: .loginButtonTitle)
        XCTAssertEqual(buttonTitle, fromViewModel, "Button title is not equal to viewModel data.")
    }
    
    func testFailedLoginErrorMessage() {
        let errorMessage = "Login and/or password are wrong."
        let fromViewModel = viewModel?.getString(for: .failedLoginMessage) ?? ""
        XCTAssertEqual(errorMessage, fromViewModel, "Failed login message is different from viewModel.")
    }
    
    func testLoginShouldFail() {
        service.loginWithEmailAndPassword("wrong@email.com", "123456") { (authCredentials, error) in
            if let error = error {
                XCTAssertNotNil(error, "Login should fail.")
            }
            
            XCTAssertNil(authCredentials, "Login shouldn't return authCredentials.")
        }
    }
    
    func testLoginShouldBeSuccessful() {
        service.loginWithEmailAndPassword("john.doe@email.com", "123456") { (authCredentials, error) in
            XCTAssertNil(error, "Login should be sucessful.")
            
            if let authCredentials = authCredentials {
                XCTAssertEqual(authCredentials.email, "john.doe@email.com", "E-mails don't match.")
                XCTAssertEqual(authCredentials.username, "John Doe", "Usernames don't match.")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
