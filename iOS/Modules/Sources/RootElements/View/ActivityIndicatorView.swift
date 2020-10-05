//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
  public init() {}
	
	// MARK: - Methods
	
	public func createViewAnimated() -> UIActivityIndicatorView {
		let view = UIActivityIndicatorView()
		view.startAnimating()
		return view
	}

	// MARK: - UIViewRepresentable
	
  public func makeUIView(context: Context) -> UIActivityIndicatorView {
    return createViewAnimated()
  }

  public func updateUIView(_ uiView: UIActivityIndicatorView,
						   context: Context) {}
}

struct ActivityIndicatorView_Previews: PreviewProvider {
	static var previews: some View {
		ActivityIndicator()
	}
}
