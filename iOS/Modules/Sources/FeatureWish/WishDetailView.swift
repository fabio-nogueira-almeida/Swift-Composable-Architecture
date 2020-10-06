//
//  File.swift
//  
//
//  Created by Fábio Nogueira de Almeida on 09/09/20.
//

import ComposableArchitecture
import CoreServices
import RootElements
import SwiftUI
import UIKit

struct WishDetailView: View {
	
	// MARK: - Property
	
	var store: Store<WishDetailState, WishDetailAction>
	
	// MARK: - Initialize
	
	public init(model: Wish, coordinator: WishCoordinator?) {
		store = Store(initialState: WishDetailState(model: model),
					  reducer: wishDetailReducer,
					  environment: WishDetailEnviroment(coordinator: coordinator,
															 mainQueue: DispatchQueue.main.eraseToAnyScheduler()))
	}
	
	public init(store: Store<WishDetailState, WishDetailAction>) {
		self.store = store
	}
	
	// Mark: Body
	
	var body: some View {
		WithViewStore(self.store) { viewStore in
			VStack{
				VStack{
					HStack{
						Button(action: {
							viewStore.send(.dismissView)
						}) {
							HStack(spacing: 10){
								Image(systemName: "arrow.left")
									.font(.system(size: 24))
									.foregroundColor(.black)
								Text("Voltar")
									.foregroundColor(.black)
							}
						}
						Spacer()
					}
					.padding()
					ImageLoaded(withURL: (viewStore.state.model.background?.small)!)
						.padding(.horizontal,45)
						.clipShape(Circle())
						.padding(.top,25)
						.frame(width: 200, height: 380, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						.padding()
					Text(viewStore.state.model.name!)
						.font(.largeTitle)
						.fontWeight(.bold)
						.foregroundColor(.black)
						.padding(.top,8)
					infos(viewStore)
					.font(.subheadline)
					.foregroundColor(.black)
					.padding(.horizontal,10)
					.padding()
				}
				.padding(.bottom,10)
				.background(
					Color.white.opacity(0.9)
						.clipShape(CustomCornerShape(corners: [.bottomLeft,.bottomRight],
													 size: 55))
						.edgesIgnoringSafeArea(.all), alignment: .top)
				Spacer()
			}
			.background(Color(viewStore.state.model.color.darker(by: 60)?
								.withAlphaComponent(0.9) ?? .darkGray)
							.edgesIgnoringSafeArea(.all))
		}
	}
	
	// MARK: - Private
	
	private func infos(_ viewStore: ViewStore<WishDetailState, WishDetailAction>) -> VStack<TupleView<(HStack<TupleView<(Text, Text)>?>, HStack<TupleView<(Text, Text)>?>, HStack<TupleView<(Text, Text)>?>)>> {
		
		return VStack(alignment: .leading, spacing: 8) {
			HStack {
				if let balance = viewStore.state.model.totalBalance!.formatted() {
					Text("Valor:")
					Text(balance)
				}
			}
			HStack {
				if let amount = viewStore.state.model.goalAmount?.formatted(){
					Text("Meta:")
					Text(amount)
				}
			}
			HStack {
				if let date = viewStore.state.model.goalDate?.dateFormatted(){
					Text("Data:")
					Text(date)
				}
			}
		}
	}
}

struct WishDetailView_Previews: PreviewProvider {
	static var previews: some View {
		WishDetailView(model: Wish(id: 1,
											name: "Test",
											balance: 123140,
											amount: 837,
											date: "2020/12/12",
											image: Background(small: "",
															  full: "",
															  regular: "")),
							coordinator: nil)
	}
}
