//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import RootElements
import SwiftUI

// MARK - Coordinator

public protocol WishCoordinatorDelegate: AnyObject {
	func goToDetail(model: Wish)
	func dismiss()
}

// MARK - PortifolioCoordinator

public final class WishCoordinator: Coordinator {
	
	// MARK: - Properties
	
	public var childCoordinators: [Coordinator] = []
	
	private var presenter: UIViewController?
	
	// MARK: - Initialize
	
	public init(presenter: UIViewController?) {
		self.presenter = presenter
	}
	
	// MARK: - Public
	
	public func start() {
		let view = WishListView(coordinator: self)
		let hosting = UIHostingController(rootView: view)
		hosting.modalPresentationStyle = .fullScreen
		presenter?.present(hosting, animated: true, completion: nil)
		presenter = hosting
	}
}

// MARK: - PortifolioCoordinatorDelegate

extension WishCoordinator: WishCoordinatorDelegate {
	
	public func goToDetail(model: Wish) {
		let view = WishDetailView(model: model, coordinator: self)
		let hosting = UIHostingController(rootView: view)
		hosting.modalPresentationStyle = .fullScreen
		presenter?.present(hosting, animated: true, completion: nil)	
	}
	
	public func dismiss() {
		presenter?.dismiss(animated: true, completion: nil)
	}
}

