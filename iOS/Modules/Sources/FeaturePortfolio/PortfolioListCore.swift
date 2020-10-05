//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import ComposableArchitecture
import SwiftUI

// MARK: - PortfolioListState

public struct PortfolioListState: Equatable {
	public init() {}
	
	public var models: [Portfolio] = []
	public var isFetchRequestInFlight: Bool?
}

// MARK: - PortfolioListAction

public enum PortfolioListAction: Equatable {
	case fetchData
	case fetchDataResponse(Result<PortfolioListResponse, PortfolioError>)
	case showDetail(_ model: Portfolio)
}

// MARK: - PortfolioListEnvironment

public struct PortfolioListEnvironment {
	public var coordinator: PortfolioCoordinatorDelegate?
	public var network: PortfolioNetwork
	public var mainQueue: AnySchedulerOf<DispatchQueue>
	
	public init(
		coordinator: PortfolioCoordinatorDelegate?,
		network: PortfolioNetwork,
		mainQueue: AnySchedulerOf<DispatchQueue>
	) {
		self.coordinator = coordinator
		self.network = network
		self.mainQueue = mainQueue
	}
}

// MARK: - PortfolioListReducer

public let portfolioListReducer = Reducer<PortfolioListState, PortfolioListAction, PortfolioListEnvironment> { state, action, environment in
	
	switch action {
		
	case .fetchData:
		state.isFetchRequestInFlight = true
		return environment.network
			.fetch()
			.receive(on: environment.mainQueue)
			.catchToEffect()
			.map(PortfolioListAction.fetchDataResponse)
		
	case let .fetchDataResponse(.success(response)):
		state.models = response.data
		state.isFetchRequestInFlight = false
		return .none

	case let .fetchDataResponse(.failure(error)):
		state.isFetchRequestInFlight = false
		return .none

	case .showDetail(let model):
		environment.coordinator?.goToDetail(model: model)
		return .none
	}
}
	.debug()
