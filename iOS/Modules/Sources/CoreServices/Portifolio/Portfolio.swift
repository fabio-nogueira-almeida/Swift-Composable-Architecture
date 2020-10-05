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

public struct PortifolioResponse: Decodable {
	public let portfolios: [Portfolio]
}

// MARK: - Portifolio

public struct Portfolio: Equatable, Identifiable  {
	public typealias Name = Tagged<Portfolio, String>
	public typealias TotalBalance = Tagged<Portfolio, Float>
	public typealias GoalAmount = Tagged<Portfolio, Float>
	public typealias GoalDate = Tagged<Portfolio, String>

	public let id: String?
	public let name: String?
	public let totalBalance: Float?
	public let goalAmount: Float?
	public let goalDate: String?
	public let background: Background?
	
	public let color: UIColor = UIColor.randomColor()

	public static func == (lhs: Portfolio, rhs: Portfolio) -> Bool {
		return lhs.id == rhs.id
	}
	
	public init(id: String, name: String, balance: Float, amount: Float, date: String, image: Background) {
		self.id = id
		self.name = name
		self.totalBalance = balance
		self.goalAmount = amount
		self.goalDate = date
		self.background = image
	}
}

// MARK: - Decodable

extension Portfolio: Decodable {
	enum PortifolioCodingKeys: String, CodingKey {
		case name, totalBalance, goalAmount, goalDate, background
		case id = "_id"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: PortifolioCodingKeys.self)
		
		id = try container.decodeIfPresent(String.self, forKey: .id)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		totalBalance = try container.decodeIfPresent(Float.self, forKey: .totalBalance)
		goalAmount = try container.decodeIfPresent(Float.self, forKey: .goalAmount)
		goalDate = try container.decodeIfPresent(String.self, forKey: .goalDate)
		background = try container.decodeIfPresent(Background.self, forKey: .background)
	}
}

// MARK: - Background

public struct Background: Decodable {
	public let thumb: String
	public let small: String
	public let full: String
	public let regular: String
	public let raw: String
	
	public init(thumb: String, small: String, full: String, regular: String, raw: String) {
		self.thumb = thumb
		self.small = small
		self.full = full
		self.regular = regular
		self.raw = raw
	}
}
