//

@testable import App
import FeatureLogin
import FeaturePortfolio
import XCTest

class AppCoordinatorTests: XCTestCase {
	
	// MARK: - Properties

	var sut: AppCoordinator?
	
	// MARK: - Lifecycle
	
	override func setUp() {
		super.setUp()
		sut = AppCoordinator(window: UIWindow())
	}
	
	// MARK: - Tests
	
	func testShouldPresentLoginFlowAsAStart() {
		sut?.start()
		XCTAssertTrue(sut?.childCoordinators.count == 1)
		XCTAssertTrue(sut?.childCoordinators.last is LoginCoordinator)
		XCTAssertFalse(sut?.childCoordinators.last is PortfolioCoordinator)
	}
	
	func testShouldPresentPortfolioFlow() {
		sut?.goToNext(flow: .portfolio)
		XCTAssertTrue(sut?.childCoordinators.count == 1)
		XCTAssertTrue(sut?.childCoordinators.last is PortfolioCoordinator)
	}
}

