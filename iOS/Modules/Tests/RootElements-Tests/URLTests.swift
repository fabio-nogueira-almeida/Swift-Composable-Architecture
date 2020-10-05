//

@testable import RootElements
import XCTest

class URLTests: XCTestCase {

	func testShouldVerifyIfBaseURLIsCorrect() {
		XCTAssert(URL.baseURL().absoluteString == "https://enigmatic-bayou-48219.herokuapp.com/api/v2")
	}
}
