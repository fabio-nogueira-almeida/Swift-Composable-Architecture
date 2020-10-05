//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import FeatureLogin
import RootElements
import SwiftUI
import UIKit

// MARK: - AppCoordinator

final class AppCoordinator: Coordinator {
	
	// MARK: - Property
	
	internal var childCoordinators: [Coordinator] = []
	
    private weak var window: UIWindow?
	
	private var presenter = UIViewController()
	
	// MARK: - Initialize
    
    init(window: UIWindow) {
        self.window = window
    }
	
	// MARK: - Private
	
	private func createHostingNavigationForViews() {
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
		childCoordinators.removeLast()
		
		switch flow {
		case .login:
			let coordinator = LoginCoordinator(presenter: presenter, delegate: self)
			childCoordinators.append(coordinator)
			coordinator.start()
		
		case .portfolioDetail:
//			let coordinator = PortfolioCoordinator(presenter: hosting)
//			childCoordinators.append(coordinator)
//			coordinator.start()
			break
		
		case .portfolioList:
			break
		}
	
	}
}
