//
//  LoginCoordinator.swift
//  App
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//  Copyright © 2020 Fábio Nogueira. All rights reserved.
//

import CoreServices
import RootElements
import SwiftUI

// MARK - Coordinator

public protocol LoginCoordinatorDelegate: AnyObject {
	func goToNextFlow()
}

// MARK - LoginCoordinator

public final class LoginCoordinator: Coordinator {
	
	// MARK: - Properties
	
	weak var coordinator: AppCoordinatorDelegate?
	
	public var childCoordinators: [Coordinator] = []
	
	private var presenter: UIViewController
	
	// MARK: - Initialize
	
	public init(presenter: UIViewController, delegate: AppCoordinatorDelegate) {
		self.coordinator = delegate
		self.presenter = presenter
	}

	// MARK: - Public
	
	public func start() {
		let view = LoginView(coordinator: self)
		let viewController = UIHostingController(rootView: view)
		viewController.modalPresentationStyle = .fullScreen
		presenter.present(viewController, animated: true, completion: nil)
	}
}

// MARK: - LoginCoordinatorDelegate

extension LoginCoordinator: LoginCoordinatorDelegate {
	public func goToNextFlow() {
		coordinator?.goToNext(flow: .wish)
	}
}
