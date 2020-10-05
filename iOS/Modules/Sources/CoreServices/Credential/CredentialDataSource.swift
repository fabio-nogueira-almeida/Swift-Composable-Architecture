//
//  CredentialDataSource.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 05/09/20.
//

import Foundation
import KeychainAccess

struct CredentialDataSource {
	
	// MARK: - Properties
	
	let autorization_token = "credential.autorization_token"
	
	// MARK: - Public
	
	func save(_ credential: Credential) {
		if let identifier = Bundle.main.bundleIdentifier {
			let keychain = Keychain(service: identifier)
			keychain[autorization_token] = credential.autorizationToken
		}
	}
	
	func getCredential() -> Credential? {
		if let identifier = Bundle.main.bundleIdentifier {
			let keychain = Keychain(service: identifier)
			
			if let autorizationToken = keychain[autorization_token] {
				return Credential(autorizationToken: autorizationToken)
			}
		}
		return nil
	}
}
