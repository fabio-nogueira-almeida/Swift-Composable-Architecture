//
//  LoginProvider.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 05/09/20.
//

import Foundation
import Moya

public struct LoginProvider {
	
	// MARK: - Properties
	
	public var provider = MoyaProvider<LoginService>()
	
	// MARK: - Initialize
	
	public init() {}
	
	// MARK: - Public
	
	public func logon(with email: String,
					  password: String,
					  completion: @escaping (Bool?) -> Void) {
		
		provider.request(.login(email: email, password: password)) { result in
			
			switch result {
			case .success(let response):
			  do {
				
				let credential = try JSONDecoder().decode(Credential.self,
														  from: response.data)
				
				self.save(credential)
				
				completion(true)
				
			  } catch {
				completion(false)
			  }
				
			case .failure:
				completion(false)
			}
		}
	}
	
	// MARK: - Private
	
	public func save(_ credential: Credential) {
		CredentialDataSource().save(credential)
	}
}
