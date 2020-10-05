//
//  AuthenticationNetwork.swift
//
//
//  Created by Fábio Nogueira de Almeida on 06/09/20.
//

import CoreServices
import ComposableArchitecture

// MARK: - AuthenticationNetwork

public struct AuthenticationNetwork {
	
	// MARK: - Properties
	
	public var login: (LoginRequest) -> Effect<AuthenticationResponse, AuthenticationError>
	
	// MARK: - Initialize
	
	public init(
		login: @escaping (LoginRequest) -> Effect<AuthenticationResponse, AuthenticationError>
	) {
		self.login = login
	}
}

// MARK: - live

extension AuthenticationNetwork {
	public static let live = AuthenticationNetwork(
		login: { request in
			Effect.future { callback in
				LoginProvider().logon(with: request.email,
									  password: request.password) { success in
					if success == true {
						callback(.success(AuthenticationResponse(success: true)))
					} else {
						callback(.failure(.invalidCredential))
					}
				}
			}
		})
}

// MARK: - LoginRequest

public struct LoginRequest {
	public var email: String
	public var password: String
	
	public init(
		email: String,
		password: String
	) {
		self.email = email
		self.password = password
	}
}

// MARK: - AuthenticationResponse

public struct AuthenticationResponse: Equatable {
	public var success: Bool
	
	public init(
		success: Bool
	) {
		self.success = success
	}
}

// MARK: - AuthenticationError

public enum AuthenticationError: Equatable, Error {
	case invalidCredential
}
