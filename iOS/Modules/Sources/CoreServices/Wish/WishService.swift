//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import Foundation
import RootElements
import Moya

// MARK: - LoginService

public enum WishService {
	case fetch
}

// MARK: - TargetType

extension WishService: TargetType {
	public var baseURL: URL {
		return URL.baseURL()
	}
	
	public var path: String {
		switch self {
		case .fetch:
			return "/whishes"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .fetch:
			return .get
		}
	}
	
	public var sampleData: Data {
		switch self {
		case .fetch:
			let json = """
			{
			"whishes": [
			{
			"_id": "5d9e29c7b6c3123b9f5f3268",
			"name": "Disney!",
			"background": {
				"thumb": "https://images.unsplash.com/photo-1463109598173-3864231fade5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"small": "https://images.unsplash.com/photo-1463109598173-3864231fade5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"full": "https://images.unsplash.com/photo-1463109598173-3864231fade5?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"regular": "https://images.unsplash.com/photo-1463109598173-3864231fade5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"raw": "https://images.unsplash.com/photo-1463109598173-3864231fade5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjg3NTU5fQ"
			},
			"totalBalance": 522.2952415271,
			"goalAmount": 200000,
			"goalDate": "2029-10-09"
			},
			{
			"_id": "5d9e2766b6c3123b9f5f3219",
			"name": "Poupança filhos",
			"background": {
				"thumb": "https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"small": "https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"full": "https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"regular": "https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjg3NTU5fQ",
				"raw": "https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjg3NTU5fQ"
			},
			"totalBalance": 0,
			"goalAmount": null,
			"goalDate": "2024-10-09"
			}]}
			"""
			
			return json.utf8Encoded
		}
	}
	
	public var task: Task {
		switch self {
		case .fetch:
			return .requestPlain
		}
	}
	
	public var headers: [String: String]? {
		return ["Content-type": "application/json",
				"Authorization": String(CredentialDataSource().getCredential()?.auth_token ?? "")]
	}
}

