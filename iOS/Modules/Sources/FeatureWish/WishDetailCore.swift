//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 10/09/20.
//

import CoreServices
import ComposableArchitecture
import SwiftUI

// MARK: - WishDetailState

public struct WishDetailState: Equatable {
	public var model: Wish
}

// MARK: WishDetailAction

public enum WishDetailAction: Equatable {
	case dismissView
}

// MARK: - WishDetailEnviroment

public struct WishDetailEnviroment {
	public var coordinator: WishCoordinatorDelegate?
	public var mainQueue: AnySchedulerOf<DispatchQueue>
	
	public init(
		coordinator: WishCoordinatorDelegate?,
		mainQueue: AnySchedulerOf<DispatchQueue>
	) {
		self.coordinator = coordinator
		self.mainQueue = mainQueue
	}
}

// MARK: - WishDetailReducer

public let wishDetailReducer = Reducer<WishDetailState, WishDetailAction, WishDetailEnviroment> { state, action, environment in
	
	switch action {
	case .dismissView:
		environment.coordinator?.dismiss()
		return .none
	}
}
	.debug()
