
//
//  CoordinatorAPI.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import Foundation
import UIKit

// MARK: - Coordinator

public protocol Coordinator : AnyObject {	
	var childCoordinators: [Coordinator] { get set }

	func start()
}

// MARK: - AppCoordinatorDelegate

public protocol AppCoordinatorDelegate: AnyObject {
	func goToNext(flow: CoordinatorState)
}

// MARK: - CoordinatorState

public enum CoordinatorState {
	case login
	case wish
}
