//

import ComposableArchitecture
import Combine
@testable import CoreServices
@testable import FeaturePortfolio
import XCTest

class PortfolioCoreTests: XCTestCase {
	
	// MARK: - Properties
	
	public static let item = Portfolio(id: "1",
									   name: "teste",
									   totalBalance: 0,
									   goalAmount: 0,
									   goalDate: "",
									   background: nil)
	
	// MARK: - Tests
	
	func testShouldFetchData() {
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: PortfolioListState(),
							  reducer: portfolioListReducer,
							  environment: PortfolioListEnvironment(network: .liveMock,
																	mainQueue: queue))
		store.assert(
			.send(.fetchData, { state in
				state.isFetchRequestInFlight = true
			}),
			.do { scheduler.advance() },
			.receive(.fetchDataResponse(.success(PortfolioListResponse(data: [PortfolioCoreTests.item]))), { state in
				state.isFetchRequestInFlight = false
				state.models = [PortfolioCoreTests.item]
			})
		)
	}
	
	func testShouldFetchDataWithFailure() {
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: PortfolioListState(),
							  reducer: portfolioListReducer,
							  environment: PortfolioListEnvironment(network: .liveFailureMock,
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
		let store = TestStore(initialState: PortfolioListState(),
							  reducer: portfolioListReducer,
							  environment: PortfolioListEnvironment(network: .liveFailureMock,
																	mainQueue: queue))
		store.assert(
			.send(.showDetail)
		)
	}
}

// MARK: - LoginEnvironmentMock

extension PortfolioNetwork {
	
	public static let liveMock = PortfolioNetwork(fetch: {
		return Effect.future { callback in
			let item = PortfolioCoreTests.item
			callback(.success(PortfolioListResponse(data: [item])))
		}
	})
	
	public static let liveFailureMock = PortfolioNetwork(fetch: {
		return Effect.future { callback in
			callback(.failure(.requestFailure))
		}
	})
}
