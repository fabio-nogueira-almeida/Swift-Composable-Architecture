//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//

import Foundation


@testable import RootElements
import XCTest

class ActivityIndicatorTests: XCTestCase {

	func testShouldVerifyIfViewIsAnimated() {
		let view = ActivityIndicator()
		XCTAssertTrue(view.createViewAnimated().isAnimating)
	}
}
