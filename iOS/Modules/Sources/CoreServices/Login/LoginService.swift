//

import Foundation
import RootElements
import Moya

// MARK: - LoginService

public enum LoginService {
	case login(email: String, password: String)
}

// MARK: - TargetType

extension LoginService: TargetType {
	public var baseURL: URL {
		return URL.baseURL()
	}
	
	public var path: String {
		switch self {
		case .login(_,_):
			return "/users/login"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .login(_,_):
			return .post
		}
	}
	
	public var sampleData: Data {
		switch self {
		case .login(_,_):
			let json =
				"""
				{"Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0b21lcklkIjoiNTgzNGFkM2MyMjdlYTVhYzdmYzBmZjAyIiwiYWNjZXNzVG9rZW5JZCI6IjVkOWU0YzQ4NTE5NzIwMDAxMWJkN2YxOSIsImFjY2Vzc1Rva2VuSGFzaCI6ImQzOWM3NTY3MGQ5MzU4NmU0NDNhZDJiMjNjMGVlMWQzZDViOTdhMDcyYzU3NmYzNjY5NTA3Mjk4ZDUzYzlmN2UiLCJpYXQiOjE1NzA2NTUzMDQsImV4cCI6MTU3MTI2MDEwNH0.k4GtMCxIX8xP-K0yNW3SGKVbL0qT40EF8h-y9gWUE04"}
				"""
			return json.utf8Encoded
		}
	}
	
	public var task: Task {
		switch self {
		case .login(let email, let password):
			return .requestParameters(parameters: ["user": ["email": email, "password": password]],
									  encoding: JSONEncoding.default)
		}
	}
	
	public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
