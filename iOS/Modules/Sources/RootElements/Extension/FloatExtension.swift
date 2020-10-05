//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 10/09/20.
//

import Foundation

extension Float {
	public func formatted() -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: "pt_BR")
		return formatter.string(from: NSNumber(value: self))
	}
}
