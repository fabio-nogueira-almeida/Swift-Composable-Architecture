//
//  File.swift
//
//
//  Created by Fábio Nogueira de Almeida on 08/09/20.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
	var didChange = PassthroughSubject<Data, Never>()
	var data = Data() {
		didSet {
			didChange.send(data)
		}
	}
	
	init(urlString:String) {
		guard let url = URL(string: urlString) else { return }
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else { return }
			DispatchQueue.main.async {
				self.data = data
			}
		}
		task.resume()
	}
}

public struct ImageLoaded: View {
	@ObservedObject var imageLoader: ImageLoader
	@State var image: UIImage = UIImage()
	
	public init(withURL url: String) {
		imageLoader = ImageLoader(urlString:url)
	}
	
	public var body: some View {
		VStack {
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fill)
		}.onReceive(imageLoader.didChange) { data in
			self.image = UIImage(data: data) ?? UIImage()
		}
	}
}

struct ImageLoadedView_Previews: PreviewProvider {
	static var previews: some View {
		ImageLoaded(withURL: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")
	}
}
