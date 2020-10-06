//

@testable import App
import FeatureLogin
import FeatureWish
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
		XCTAssertFalse(sut?.childCoordinators.last is WishCoordinator)
	}
	
	func testShouldPresentWishFlow() {
		sut?.goToNext(flow: .wish)
		XCTAssertTrue(sut?.childCoordinators.count == 1)
		XCTAssertTrue(sut?.childCoordinators.last is WishCoordinator)
	}
}

