//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import Foundation
import Moya

public struct PortfolioProvider {
	
	// MARK: - Properties
	
	public var provider = MoyaProvider<PortfolioService>()
	
	// MARK: - Initialize
	
	public init() {}
	
	// MARK: - Public
	
	public func fetch(completion: @escaping ([Portfolio]?) -> Void) {
		
		provider.request(.fetch) { result in
			
			switch result {
			case .success(let response):
			  do {
				let results = try JSONDecoder().decode(PortifolioResponse.self, from: response.data)
				completion(results.portfolios)
			  } catch {
				completion(nil)
			  }
			case .failure:
				completion(nil)
			}
		}
	}
}

