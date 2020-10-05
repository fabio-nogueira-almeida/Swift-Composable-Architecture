//
//  LoginView.swift
//
//
//  Created by Fábio Nogueira de Almeida on 05/09/20.
//

import ComposableArchitecture
import RootElements
import SwiftUI

public struct LoginView: View {
	
	// MARK: - Property
	
	let store: Store<LoginState, LoginAction>
	
	// MARK: - Initialize
	
	public init(coordinator: LoginCoordinatorDelegate?) {
		store = Store(initialState: LoginState(),
					  reducer: loginReducer,
					  environment: LoginEnvironment(
						network: .live,
						mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
						coodinatorDelegate: coordinator))
	}
	
	// MARK: - Body
	
	public var body: some View {
		
		WithViewStore(self.store) { viewStore in
			NavigationView {
				GeometryReader { _ in
					VStack {
						Image("WishLogoWithText")
							.resizable()
							.frame(width: 140, height: 140)
						ZStack(alignment: .bottom) {
							Form(viewStore)
							Button(viewStore)
						}
					}
					Spacer()
				}
				.background(Color("Black").edgesIgnoringSafeArea(.all))
			}
			.preferredColorScheme(.dark)
		}
	}
	
	// MARK: - Private
	
	private func Button(_ viewStore: ViewStore<LoginState, LoginAction>) -> some View {
		return VStack {
			SwiftUI.Button(action: {
				if viewStore.isFormValid == true {
					viewStore.send(.loginButtonTapped)
				}
			}) {
				Text("Entrar")
					.foregroundColor(.white)
					.fontWeight(.bold)
					.padding(.vertical)
					.padding(.horizontal, 40)
					.background(Color("Pink"))
					.clipShape(Capsule())
					.shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
			}
			.offset(y: 25)
			.alert(self.store.scope(state: \.alert), dismiss: .dismissAlertError)
		}
	}
	
	private func Form(_ viewStore: ViewStore<LoginState, LoginAction>) -> some View {
		return VStack {
			VStack {
				HStack(spacing: 10) {
					Spacer()
					Image(systemName: "envelope.fill")
						.foregroundColor(Color("Pink"))
					TextField(
						"e-mail",
						text: viewStore.binding(
							get: \.email ,
							send: { .emailTextFieldChanged(text: $0) }
						)
					)
					.frame(height: 40)
					.accentColor(Color("Pink"))
				}
				.background(Color.white)
				.cornerRadius(10)
			}
			.padding(.horizontal)
			.padding(.top, 10)
			VStack {
				HStack(spacing: 10) {
					Spacer()
					Image(systemName: "eye.slash.fill")
						.foregroundColor(Color("Pink"))
					SecureField(
						"Senha",
						text: viewStore.binding(
							get: \.password ,
							send: { .passwordTextFieldChanged(text: $0) }
						)
					)
					.frame(height: 40)
					.accentColor(Color("Pink"))
				}
				.background(Color.white)
				.cornerRadius(10)
			}
			.padding(.horizontal)
			.padding(.top, 10)
		}
		.padding()
		.padding(.bottom, 30)
		.background(Color("DarkBlue"))
		.cornerRadius(10)
		.padding(.horizontal, 30)
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView(coordinator: nil)
	}
}
