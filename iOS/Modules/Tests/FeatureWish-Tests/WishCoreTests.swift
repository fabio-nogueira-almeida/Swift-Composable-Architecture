//

import ComposableArchitecture
import Combine
@testable import CoreServices
@testable import FeatureWish
import XCTest

class WishCoreTests: XCTestCase {
	
	// MARK: - Properties
	
	public static let item = Wish(id: "1",
									   name: "teste",
									   totalBalance: 0,
									   goalAmount: 0,
									   goalDate: "",
									   background: nil)
	
	// MARK: - Tests
	
	func testShouldFetchData() {
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: WishListState(),
							  reducer: wishListReducer,
							  environment: WishListEnvironment(network: .liveMock,
																	mainQueue: queue))
		store.assert(
			.send(.fetchData, { state in
				state.isFetchRequestInFlight = true
			}),
			.do { scheduler.advance() },
			.receive(.fetchDataResponse(.success(WishListResponse(data: [WishCoreTests.item]))), { state in
				state.isFetchRequestInFlight = false
				state.models = [WishCoreTests.item]
			})
		)
	}
	
	func testShouldFetchDataWithFailure() {
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: WishListState(),
							  reducer: wish
							  environment: WishListEnvironment(network: .liveFailureMock,
																	mainQueue: queue))
		store.assert(
			.send(.fetchData, { state in
				state.isFetchRequestInFlight = true
			}),
			.do { scheduler.advance() },
			.receive(.fetchDataResponse(.failure(.requestFailure)), { state in
				state.isFetchRequestInFlight = false
			})
		)
	}
	
	func testShouldShowDetailScreen()  {
		let queue = DispatchQueue.testScheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: WishoListState(),
							  reducer: wishListReducer,
							  environment: WishListEnvironment(network: .liveFailureMock,
																	mainQueue: queue))
		store.assert(
			.send(.showDetail)
		)
	}
}

// MARK: - LoginEnvironmentMock

extension WishNetwork {
	
	public static let liveMock = WishNetwork(fetch: {
		return Effect.future { callback in
			let item = WishCoreTests.item
			callback(.success(WishoListResponse(data: [item])))
		}
	})
	
	public static let liveFailureMock = WishNetwork(fetch: {
		return Effect.future { callback in
			callback(.failure(.requestFailure))
		}
	})
}
