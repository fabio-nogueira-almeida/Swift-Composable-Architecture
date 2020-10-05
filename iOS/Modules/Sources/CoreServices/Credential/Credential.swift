//
//  Credential.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 05/09/20.
//

import Foundation

// MARK: - Credential

public struct Credential: Decodable {
	let autorizationToken: String
	
	init(autorizationToken: String) {
		self.autorizationToken = autorizationToken
	}
}
