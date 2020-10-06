//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 07/09/20.
//

import CoreServices
import Combine
import ComposableArchitecture
import SwiftUI
import RootElements
import UIKit

// MARK: - PortfolioListView

public struct PortfolioListView : View {
	
	// MARK: - Property
	
	var store: Store<PortfolioListState, PortfolioListAction>
	
	// MARK: - Initialize
	
	public init(coordinator: PortfolioCoordinatorDelegate?) {
		store = Store(initialState: PortfolioListState(),
					  reducer: portfolioListReducer,
					  environment: PortfolioListEnvironment(
						coordinator: coordinator,
						network: .live,
						mainQueue: DispatchQueue.main.eraseToAnyScheduler()))
	}
	
	public init(store: Store<PortfolioListState, PortfolioListAction>) {
		self.store = store
	}
	
	// Mark: Body
	
	public var body: some View {
		
		WithViewStore(self.store) { viewStore in
			ZStack {
				VStack {
					HStack {
						Text("Portfolio")
							.font(.largeTitle)
							.fontWeight(.bold)
							.foregroundColor(.white)
						Spacer()
					}
					.padding()
					ScrollView(.vertical, showsIndicators: false) {
						VStack(spacing: 15) {
							if viewStore.isFetchRequestInFlight == false  {
								ForEach(viewStore.models) { model in
									Button(action: { viewStore.send(.showDetail(model)) }) {
									CardView(store: self.store, model: model)
										.shadow(color: Color.black.opacity(0.16),
												radius: 5, x: 0, y: 5)
									}
								}
							} else {
								HStack {
									Spacer()
									ActivityIndicator().padding()
									Spacer()
								}
							}
						}
						.padding(.horizontal, 26)
					}
					.background(
						Color.white
							.clipShape(CustomCornerShape(corners: [.topLeft, .topRight],
														 size: 55))
							.edgesIgnoringSafeArea(.all), alignment: .bottom)
					.padding(.top, 40)
				}
			}
			.background(Color("Black").edgesIgnoringSafeArea(.all))
			.onAppear {
				if viewStore.state.models.isEmpty {
					viewStore.send(.fetchData)
				}
			}
		}
	}
}

// MARK: - Card View

struct CardView: View {
	
	let store: Store<PortfolioListState, PortfolioListAction>
	var model: Portfolio
	
	var body: some View {
		WithViewStore(self.store) { viewStore in
			HStack(spacing: 0) {
				Text(self.model.name!)
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.black)
				Spacer()
				Spacer()
				ImageLoaded(withURL: (self.model.background?.small)!)
					.frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
					.clipShape(Circle())
			}
			.padding()
			.background(Color.white.cornerRadius(25).padding(.top, 35))
			.padding(.trailing, 10)
			.background(Color.init(self.model.color.withAlphaComponent(0.5))
							.cornerRadius(25)
							.padding(.top, 35))
		}.debug()
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(store: Store(initialState: PortfolioListState(),
							  reducer: portfolioListReducer,
						environment: PortfolioListEnvironment(
						  coordinator: nil,
						  network: .live,
						  mainQueue: DispatchQueue.main.eraseToAnyScheduler())),
				 model: Portfolio(id: "789SDFHJK124789DSHJKA",
								  name: "Test",
										   balance: 123140,
										   amount: 837,
										   date: "2020/12/12",
										   image: Background(small: "",
															 full: "",
															 regular: "")))
			.background(Color.gray)
	}
}
