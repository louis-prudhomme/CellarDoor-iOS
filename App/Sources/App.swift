import Dependencies
import SharedCommonArchitecture
import SharedCommonModelContainer
import SwiftUI

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
