//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import ComposableArchitecture

// MARK: - PortfolioNetwork

public struct PortfolioNetwork {
	
	// MARK: - Properties
	
	public var fetch: () -> Effect<PortfolioListResponse, PortfolioError>
	
	// MARK: - Initialize
	
	public init(
		fetch: @escaping () -> Effect<PortfolioListResponse, PortfolioError>
	) {
		self.fetch = fetch
	}
}

// MARK: - live

extension PortfolioNetwork {
	public static let live = PortfolioNetwork { () -> Effect<PortfolioListResponse, PortfolioError> in
		Effect.future { (callback) in
			PortfolioProvider().fetch { results in
				if let results = results {
					callback(.success(PortfolioListResponse(data: results)))
				} else {
					callback(.failure(.requestFailure))
				}
			}
		}
	}
}

// MARK: - AuthenticationResponse

public struct PortfolioListResponse: Equatable {
	
	public var data: [Portfolio]
	
	public init(
		data: [Portfolio]
	) {
		self.data = data
	}
}

// MARK: - PortfolioError

public enum PortfolioError: Equatable, Error {
	case requestFailure
}
