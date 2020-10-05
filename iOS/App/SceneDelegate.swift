//
//  SceneDelegate.swift
//  App
//
//  Created by Fábio Nogueira on 20/02/20.
//  Copyright © 2020 Fábio Nogueira. All rights reserved.
//

import App
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	// MARK: - Properties
    
	var window: UIWindow?
	
	var coordinator: AppCoordinator?

	// MARK: - Override

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
        if let windowScene = scene as? UIWindowScene {
			
            let window = UIWindow(windowScene: windowScene)
			
			coordinator = AppCoordinator(window: window)
			coordinator?.start()

            self.window = window
			
            window.makeKeyAndVisible()
        }
    }
}

