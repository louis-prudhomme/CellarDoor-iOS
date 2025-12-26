//
//  CellarDoorApp.swift
//  Cellar Door
//
//  Created by Louis Prud'homme on 26/12/2025.
//

import SwiftUI
import Dependencies
import SharedCommonArchitecture
import SharedCommonModelContainer

@main
struct CellarDoorApp: App {
    init() {
        prepareDependencies {
            $0.modelContainer = ModelContainerConfiguration.initialize()
        }
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                store: Store(initialState: AppCoordinator.State()) {
                    AppCoordinator()
                }
            )
        }
    }
}
