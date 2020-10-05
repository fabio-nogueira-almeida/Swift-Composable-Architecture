//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import UIKit

public extension UIColor {
	static func randomColor() -> UIColor {
		 let red:CGFloat = CGFloat(drand48())
		 let green:CGFloat = CGFloat(drand48())
		 let blue:CGFloat = CGFloat(drand48())
		return UIColor(red:red, green: green, blue: blue, alpha: 1)
	}
	
	func darker(by percentage: CGFloat = 30.0) -> UIColor? {
		return self.adjust(by: -1 * abs(percentage) )
	}

	private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return UIColor(red: min(red + percentage/100, 1.0),
						   green: min(green + percentage/100, 1.0),
						   blue: min(blue + percentage/100, 1.0),
						   alpha: alpha)
		} else {
			return nil
		}
	}
}
