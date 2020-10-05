//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//

@testable import RootElements
import XCTest

class UIColorExtensionTests: XCTestCase {

	func testShouldVerifyIfRandomColorWillBeReturned() {
		XCTAssertNotNil(UIColor.randomColor())
	}
}
