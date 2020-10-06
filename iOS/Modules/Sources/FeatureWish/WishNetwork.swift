//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import ComposableArchitecture

// MARK: - WishNetwork

public struct WishNetwork {
	
	// MARK: - Properties
	
	public var fetch: () -> Effect<WishListResponse, WishError>
	
	// MARK: - Initialize
	
	public init(
		fetch: @escaping () -> Effect<WishListResponse, WishError>
	) {
		self.fetch = fetch
	}
}

// MARK: - live

extension WishNetwork {
	public static let live = WishNetwork { () -> Effect<WishListResponse, WishError> in
		Effect.future { (callback) in
			WishProvider().fetch { results in
				if let results = results {
					callback(.success(WishListResponse(data: results)))
				} else {
					callback(.failure(.requestFailure))
				}
			}
		}
	}
}

// MARK: - AuthenticationResponse

public struct WishListResponse: Equatable {
	
	public var data: [Wish]
	
	public init(
		data: [Wish]
	) {
		self.data = data
	}
}

// MARK: - WishError

public enum WishError: Equatable, Error {
	case requestFailure
}
