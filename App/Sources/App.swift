import Dependencies
import SharedCommonArchitecture
import SharedCommonModelContainer
import SwiftUI

@main
struct CellarDoorApp: App {
    init() {
        do {
            let modelContainer = try ModelContainerConfiguration.initialize()
            prepareDependencies {
                $0.modelContainer = modelContainer
            }
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
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
