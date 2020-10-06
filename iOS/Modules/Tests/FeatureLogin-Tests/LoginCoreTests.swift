//

import ComposableArchitecture
import Combine
@testable import CoreServices
@testable import FeatureLogin
import XCTest

class LoginCoreTests: XCTestCase {
	
	// MARK: - Tests
	
	func testShouldBeEqualNewValueOfEmailTextField() {
		let text = "new text"
		let queue = DispatchQueue.testScheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: LoginState(),
							  reducer: loginReducer,
							  environment: LoginEnvironment(network: .live,
															mainQueue: queue,
															coodinatorDelegate: nil))
		store.assert(
			.send(.emailTextFieldChanged(text: text), { state in
				state.email = text
			})
		)
	}
	
	func testShouldBeEqualNewValueOfPasswordTextField() {
		let text = "new text"
		let queue = DispatchQueue.testScheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: LoginState(),
							  reducer: loginReducer,
							  environment: LoginEnvironment(network: .live,
															mainQueue: queue,
															coodinatorDelegate: nil))
		store.assert(
			.send(.passwordTextFieldChanged(text: text), { state in
				state.password = text
			})
		)
	}
	
	func testShouldVerifyLogin() {
		let delegateMock = LoginCordinatorDelegateMock()
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: LoginState(),
							  reducer: loginReducer,
							  environment: LoginEnvironment(network: .liveMock,
															mainQueue: queue,
															coodinatorDelegate: delegateMock))
		store.assert(
			.send(.loginButtonTapped),
			.do { scheduler.advance() },
			.receive(.loginResponse(.success(.init(success: true)))),
			.receive(.goHome) { _ in
				XCTAssertTrue(delegateMock.isGoToNextFlowCalled)
			}
		)
	}
	
	func testShouldVerifyErrorWhenTheUserTryLogin() {
		let scheduler = DispatchQueue.testScheduler
		let queue = scheduler.eraseToAnyScheduler()
		let store = TestStore(initialState: LoginState(),
							  reducer: loginReducer,
							  environment: LoginEnvironment(network: .liveFailureMock,
															mainQueue: queue,
															coodinatorDelegate: nil))
		store.assert(
			.send(.loginButtonTapped),
			.do { scheduler.advance() },
			.receive(.loginResponse(.failure(.invalidCredential))),
			.receive(.showAlertError) { state in
				state.alert = AlertState(title: "Falha na autenticação",
										 dismissButton: .default("Ok"))
			}
		)
	}
}

// MARK: - LoginEnvironmentMock

extension AuthenticationNetwork {
	
	public static let liveMock = AuthenticationNetwork(
		login: { request in
			Effect.future { callback in
				callback(.success(AuthenticationResponse(success: true)))
			}
		})
	
	public static let liveFailureMock = AuthenticationNetwork(
		login: { request in
			Effect.future { callback in
				callback(.failure(.invalidCredential))
			}
		})
}
// MARK: - LoginCordinatorDelegateMock

class LoginCordinatorDelegateMock: LoginCoordinatorDelegate {
	
	var isGoToNextFlowCalled = false
	
	func goToNextFlow() {
		self.isGoToNextFlowCalled = true
	}
}
