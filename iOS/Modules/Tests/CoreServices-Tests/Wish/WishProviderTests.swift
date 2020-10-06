//
//  File.swift
//
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//

@testable import CoreServices
import Moya
import XCTest

class WishProviderTests: XCTestCase {
	
	// MARK: - Properties

	var sut = WishProvider()
	
	// MARK: - Lifecycle
	
	override func setUp() {
		super.setUp()
		sut.provider = MoyaProvider<WishService>(stubClosure: MoyaProvider.immediatelyStub)
	}
	
	// MARK: - Tests
	
	func testShouldValidFetchRequest() {
		let expectation = self.expectation(description: "request")
		
		sut.fetch { results in
			XCTAssert(results?.count == 2)
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 0, handler: nil)
	}
}

