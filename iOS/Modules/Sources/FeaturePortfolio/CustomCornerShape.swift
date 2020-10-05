//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import SwiftUI

struct CustomCornerShape: Shape {
	var corners: UIRectCorner
	var size: CGFloat
	
	func path(in rect: CGRect) -> Path {
		
		let path = UIBezierPath(roundedRect: rect,
								byRoundingCorners: corners,
								cornerRadii: CGSize(width: size,
													height: size))
		return Path(path.cgPath)
	}
}
