//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 10/09/20.
//

import CoreServices
import ComposableArchitecture
import SwiftUI

// MARK: - PortfolioDetailState

public struct PortfolioDetailState: Equatable {
	public var model: Portfolio
}

// MARK: - PortfolioDetailAction

public enum PortfolioDetailAction: Equatable {
	case dismissView
}

// MARK: - PortfolioDetailEnviroment

public struct PortfolioDetailEnviroment {
	public var coordinator: PortfolioCoordinatorDelegate?
	public var mainQueue: AnySchedulerOf<DispatchQueue>
	
	public init(
		coordinator: PortfolioCoordinatorDelegate?,
		mainQueue: AnySchedulerOf<DispatchQueue>
	) {
		self.coordinator = coordinator
		self.mainQueue = mainQueue
	}
}

// MARK: - PortfolioDetailReducer

public let portfolioDetailReducer = Reducer<PortfolioDetailState, PortfolioDetailAction, PortfolioDetailEnviroment> { state, action, environment in
	
	switch action {
	case .dismissView:
		environment.coordinator?.dismiss()
		return .none
	}
}
	.debug()
