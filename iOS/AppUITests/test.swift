//
//  test.swift
//  AppUITests
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//  Copyright © 2020 Fábio Nogueira. All rights reserved.
//

import XCTest

import App
import ComposableArchitecture
import FeaturePortfolio
import XCTest
//@testable import CoreServices
//@testable import FeaturePortfolio

class LoginCoreTests: XCTestCase {
	func testOnAppearAction() {
		let store = TestStore(initialState: PortfolioListState(),
							  reducer: portfolioListReducer,
							  environment: PortfolioListEnvironment(network: .live,
																	mainQueue: DispatchQueue.main.eraseToAnyScheduler()))

		store.assert(

		)
	}
}
