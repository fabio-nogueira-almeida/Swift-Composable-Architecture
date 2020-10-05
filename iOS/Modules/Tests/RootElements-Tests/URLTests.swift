//

@testable import RootElements
import XCTest

class URLTests: XCTestCase {

	func testShouldVerifyIfBaseURLIsCorrect() {
		XCTAssert(URL.baseURL().absoluteString == "https://oneforallapi.herokuapp.com")
	}
}
