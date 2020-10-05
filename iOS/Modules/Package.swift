// swift-tools-version:5.1

/**
 This Package defines the modular architecture used by our app.

 Note: A Feature module can import Core, Root and Dependencies modules. And can't import other Feature modules or even the App module.

 App -> Features -> Core -> Root -> Dependencies

*/

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Modules",
            targets: [
                // MARK: Root modules
                "RootElements",

                // MARK: Core modules
                "CoreServices",

                // MARK: Features modules
                "FeatureLogin",
				"FeaturePortfolio",

                // MARK: App
                "App"
            ]
        )
    ],
    dependencies: [
//        .package(
//            url: "https://github.com/chrisaljoudi/swift-log-oslog.git",
//            from: "0.2.1"
//        ),
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            from: "4.1.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-tagged.git",
            from: "0.5.0"
        ),
        .package(
            url: "https://github.com/Moya/Moya.git",
			.branch("development")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "0.8.0"
        )
		
		
    ],
    targets: [
        // MARK: - Root

        /// This module contains elements that are common to multiple frameworks.
        /// Like UserDefaults components, Container ViewControllers, etc.
        .target(
            name: "RootElements",
            dependencies: [
//                "LoggingOSLog",
                "Tagged"
            ]
        ),
        .testTarget(
            name: "RootElements-Tests",
            dependencies: [
                "RootElements"
            ]
        ),
		
		// MARK: - CoreServices

        /// This module contains the all the functionality that connects to an external service.
        /// Like API calls, Endpoints, Keychain etc.
        .target(
            name: "CoreServices",
            dependencies: [
                "RootElements",
                "KeychainAccess",
                "Moya"
            ]
        ),
        .testTarget(
            name: "CoreServices-Tests",
            dependencies: [
                "CoreServices"
            ]
        ),
		// MARK: - Feature

        /// This modules contains the app login
        .target(
            name: "FeatureLogin",
            dependencies: [
                "CoreServices",
				"ComposableArchitecture"
            ]
        ),
        .testTarget(
            name: "FeatureLogin-Tests",
            dependencies: [
                "FeatureLogin"
            ]
        ),
		
        /// This modules contains the app login
        .target(
            name: "FeaturePortfolio",
            dependencies: [
                "CoreServices",
				"ComposableArchitecture"
            ]
        ),
        .testTarget(
            name: "FeaturePortfolio-Tests",
            dependencies: [
                "FeaturePortfolio"
            ]
        ),

        // MARK: - App
        .target(
            name: "App",
            dependencies: [
                "FeatureLogin",
				"FeaturePortfolio"
            ]
        ),
        .testTarget(
            name: "App-Tests",
            dependencies: [
                "App"
            ]
        )
    ]
)
