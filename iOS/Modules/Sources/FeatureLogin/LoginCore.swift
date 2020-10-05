//

import ComposableArchitecture
import SwiftUI

// MARK: - LoginState

public struct LoginState: Equatable {
	public init() {}
	
	public var email = ""
	public var password = ""
	
	public var alert: AlertState<LoginAction>?
	public var isFormValid: Bool?
	public var isFetchRequestInFlight: Bool?
}

// MARK: - LoginAction

public enum LoginAction: Equatable {
	case emailTextFieldChanged(text: String)
	case passwordTextFieldChanged(text: String)
	case loginButtonTapped
	case loginResponse(Result<AuthenticationResponse, AuthenticationError>)
	case showAlertError
	case dismissAlertError
	case goHome
}

// MARK: - LoginEnvironment

public struct LoginEnvironment {
	public var network: AuthenticationNetwork
	public var mainQueue: AnySchedulerOf<DispatchQueue>
	public var coordinator: LoginCoordinatorDelegate?
	
	public init(
		network: AuthenticationNetwork,
		mainQueue: AnySchedulerOf<DispatchQueue>,
		coodinatorDelegate: LoginCoordinatorDelegate?
	) {
		self.network = network
		self.mainQueue = mainQueue
		self.coordinator = coodinatorDelegate
	}
}

// MARK: - LoginReducer

public let loginReducer = Reducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
	
	switch action {
		
	case .emailTextFieldChanged(text: let text):
		state.email = text
		state.isFormValid = !state.email.isEmpty && !state.password.isEmpty
		return .none
		
	case .passwordTextFieldChanged(text: let text):
		state.password = text
		state.isFormValid = !state.email.isEmpty && !state.password.isEmpty
		return .none
		
	case .loginButtonTapped:
			state.isFetchRequestInFlight = true
		return environment.network
			.login(LoginRequest(email: state.email, password: state.password))
			.receive(on: environment.mainQueue)
			.catchToEffect()
			.map(LoginAction.loginResponse)
		
	case let .loginResponse(.success(response)):
		state.isFetchRequestInFlight = false
		return Effect.init(value: .goHome).eraseToEffect()
		
	case let .loginResponse(.failure(error)):
		state.isFetchRequestInFlight = false
		return Effect(value: .showAlertError).eraseToEffect()
		
	case .showAlertError:
		state.alert = AlertState(title: "Falha na autenticação",
								 dismissButton: .default("Ok"))
		return .none
		
	case .dismissAlertError:
		return .none
		
	case .goHome:
		environment.coordinator?.goToNextFlow()
		return .none
		
	}
}
	.debug()
