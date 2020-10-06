//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import Foundation
import UIKit
import Tagged

// MARK: - PortifolioResponse

public struct WishResponse: Decodable {
	public let wishs: [Wish]
}

// MARK: - Portifolio

public struct Wish: Equatable, Identifiable  {
	public typealias Name = Tagged<Wish, String>
	public typealias TotalBalance = Tagged<Wish, Float>
	public typealias GoalAmount = Tagged<Wish, Float>
	public typealias GoalDate = Tagged<Wish, String>

	public let id: Int?
	public let name: String?
	public let totalBalance: Float?
	public let goalAmount: Float?
	public let goalDate: String?
	public let background: Background?
	
	public let color: UIColor = UIColor.randomColor()

	public static func == (lhs: Wish, rhs: Wish) -> Bool {
		return lhs.name == rhs.name
	}
	
	public init(id: Int, name: String, balance: Float, amount: Float, date: String, image: Background) {
		self.id = id
		self.name = name
		self.totalBalance = balance
		self.goalAmount = amount
		self.goalDate = date
		self.background = image
	}
}

// MARK: - Decodable

extension Wish: Decodable {
	enum WishCodingKeys: String, CodingKey {
		case id, name, totalBalance, goalAmount, goalDate, background
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: WishCodingKeys.self)
		
		id = try container.decodeIfPresent(Int.self, forKey: .id)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		totalBalance = try container.decodeIfPresent(Float.self, forKey: .totalBalance)
		goalAmount = try container.decodeIfPresent(Float.self, forKey: .goalAmount)
		goalDate = try container.decodeIfPresent(String.self, forKey: .goalDate)
		background = try container.decodeIfPresent(Background.self, forKey: .background)
	}
}

// MARK: - Background

public struct Background: Decodable {
	public let small: String
	public let full: String
	public let regular: String
	
	public init(small: String, full: String, regular: String) {
		self.small = small
		self.full = full
		self.regular = regular
	}
}
