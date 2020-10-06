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

// MARK: - WishListView

public struct WishListView : View {
	
	// MARK: - Property
	
	var store: Store<WishListState, WishListAction>
	
	// MARK: - Initialize
	
	public init(coordinator: WishCoordinatorDelegate?) {
		store = Store(initialState: WishListState(),
					  reducer: wishListReducer,
					  environment: WishListEnvironment(
						coordinator: coordinator,
						network: .live,
						mainQueue: DispatchQueue.main.eraseToAnyScheduler()))
	}
	
	public init(store: Store<WishListState, WishListAction>) {
		self.store = store
	}
	
	// Mark: Body
	
	public var body: some View {
		
		WithViewStore(self.store) { viewStore in
			ZStack {
				VStack {
					HStack {
						Text("Desejos")
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
	
	let store: Store<WishListState, WishListAction>
	var model: Wish
	
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
		CardView(store: Store(initialState: WishListState(),
							  reducer: wishListReducer,
						environment: WishListEnvironment(
						  coordinator: nil,
						  network: .live,
						  mainQueue: DispatchQueue.main.eraseToAnyScheduler())),
				 model: Wish(id: 1,
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
