//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import ComposableArchitecture
import SwiftUI

// MARK: - WishListState

public struct WishListState: Equatable {
	public init() {}
	
	public var models: [Wish] = []
	public var isFetchRequestInFlight: Bool?
}

// MARK: - WishListAction

public enum WishListAction: Equatable {
	case fetchData
	case fetchDataResponse(Result<WishListResponse, WishError>)
	case showDetail(_ model: Wish)
}

// MARK: - WishListEnvironment

public struct WishListEnvironment {
	public var coordinator: WishCoordinatorDelegate?
	public var network: WishNetwork
	public var mainQueue: AnySchedulerOf<DispatchQueue>
	
	public init(
		coordinator: WishCoordinatorDelegate?,
		network: WishNetwork,
		mainQueue: AnySchedulerOf<DispatchQueue>
	) {
		self.coordinator = coordinator
		self.network = network
		self.mainQueue = mainQueue
	}
}

// MARK: - WishListReducer

public let wishListReducer = Reducer<WishListState, WishListAction, WishListEnvironment> { state, action, environment in
	
	switch action {
		
	case .fetchData:
		state.isFetchRequestInFlight = true
		return environment.network
			.fetch()
			.receive(on: environment.mainQueue)
			.catchToEffect()
			.map(WishListAction.fetchDataResponse)
		
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
