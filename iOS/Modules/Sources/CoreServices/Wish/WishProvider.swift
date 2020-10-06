//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import Foundation
import Moya

public struct WishProvider {
	
	// MARK: - Properties
	
	public var provider = MoyaProvider<WishService>()
	
	// MARK: - Initialize
	
	public init() {}
	
	// MARK: - Public
	
	public func fetch(completion: @escaping ([Wish]?) -> Void) {
		
		provider.request(.fetch) { result in
			
			switch result {
			case .success(let response):
			  do {
				let results = try JSONDecoder().decode(WishResponse.self, from: response.data)
				completion(results.wishs)
			  } catch {
				completion(nil)
			  }
			case .failure:
				completion(nil)
			}
		}
	}
}

