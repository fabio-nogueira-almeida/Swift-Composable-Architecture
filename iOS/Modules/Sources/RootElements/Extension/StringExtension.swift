//

import Foundation
import UIKit

// MARK: - Helpers

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
	
	func transformToImage(completion: @escaping (UIImage?) -> ()) {
		guard let url = URL(string: self) else { return }
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data, error == nil else { return }
			DispatchQueue.main.async {
				completion(UIImage(data: data))
			}
		}
	}
	
	func dateFormatted() -> String? {
		let formatterStringToDate = DateFormatter()
		formatterStringToDate.dateFormat = "yyyy-MM-dd"
		
		if let date = formatterStringToDate.date(from: self) {
			let formatterDateToString = DateFormatter()
			formatterDateToString.dateFormat = "dd/MM/yyyy"
			return formatterDateToString.string(from: date)
		}
		return nil
	}
}

