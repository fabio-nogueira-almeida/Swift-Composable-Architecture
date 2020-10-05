//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//

@testable import CoreServices
import Moya
import XCTest

class LoginProviderTests: XCTestCase {
	
	// MARK: - Properties

	var sut = LoginProvider()
	
	// MARK: - Lifecycle
	
	override func setUp() {
		super.setUp()
		sut.provider = MoyaProvider<LoginService>(stubClosure: MoyaProvider.immediatelyStub)
	}
	
	// MARK: - Tests
	
	func testShouldValidTheLoginRequest() {
		let expectation = self.expectation(description: "request")

		sut.logon(with: "email", password: "senha") { success in
			XCTAssertTrue(success == true)
			expectation.fulfill()
		}
		waitForExpectations(timeout: 0, handler: nil)
	}
}

