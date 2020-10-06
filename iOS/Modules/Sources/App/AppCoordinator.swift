//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import FeatureLogin
import FeatureWish
import SwiftUI
import UIKit
import RootElements

// MARK: - AppCoordinator

final class AppCoordinator: Coordinator {
	
	// MARK: - Property
	
	internal var childCoordinators: [Coordinator] = []
	
    private weak var window: UIWindow?
	
	private var presenter: UIViewController?
	
	// MARK: - Initialize
    
    init(window: UIWindow) {
        self.window = window
		createHostingNavigationForViews()
    }
	
	// MARK: - Private
	
	private func createHostingNavigationForViews() {
		let viewController = UIViewController()
		viewController.view.backgroundColor = UIColor.init(named: "Black")
		presenter = viewController
		window?.rootViewController = presenter
		window?.makeKeyAndVisible()
	}
	
	// MARK: - Public
	
    func start() {
		goToNext(flow: .login)
    }
}

// MARK: - AppCoordinatorDelegate

extension AppCoordinator: AppCoordinatorDelegate {
	
	func goToNext(flow: CoordinatorState) {
		if childCoordinators.isEmpty == false {
			childCoordinators.removeLast()
		}
		
		let topViewController = UIApplication.shared.windows.last?.rootViewController
		
		switch flow {
		case .login:
			let coordinator = LoginCoordinator(presenter: (topViewController ?? presenter)!,
											   delegate: self)
			childCoordinators.append(coordinator)
			coordinator.start()
		
		case .wish:
			let coordinator = WishCoordinator(presenter: topViewController ?? presenter)
			childCoordinators.append(coordinator)
			coordinator.start()
			break
		}
	
	}
}
