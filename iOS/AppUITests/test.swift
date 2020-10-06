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
import FeatureWish
import XCTest

class LoginCoreTests: XCTestCase {
	func testOnAppearAction() {
		let store = TestStore(initialState: WishListState(),
							  reducer: wishListReducer,
							  environment: WishListEnvironment(coordinator: nil,
															   network: .live,
															   mainQueue: DispatchQueue.main.eraseToAnyScheduler()))

		store.assert(

		)
	}
}
