import Dependencies
import SharedCommonArchitecture
import SharedCommonModelContainer
import SwiftUI

#if WINE
import WineCoordinator
#endif

@main
struct CentralDispatch: App {
    @State private var initializationError: (any Error)?
    @Dependency(\.modelContainerConfigurator) var modelContainerConfigurator

    init() {
        do {
            let modelContainer = try modelContainerConfigurator.initialize()
            prepareDependencies {
                $0.modelContainer = modelContainer
            }
        } catch {
            print("❌ Failed to initialize ModelContainer: \(error)")
            print("Error details: \(String(describing: error))")
            _initializationError = State(initialValue: error)
        }
    }

    var body: some Scene {
        WindowGroup {
            if let error = initializationError {
                ErrorView(error: error)
            } else {
#if WINE
                WineCoordinatorView(
                    store: Store(initialState: WineCoordinator.State()) {
                        WineCoordinator()
                    }
                )
#else
                ErrorView(error: AppInitializationError.noFeatureEnabled)
#endif
            }
        }
    }
}

private struct ErrorView: View {
    let error: any Error

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
                .accessibilityHidden(true)

            Text("Initialization Error")
                .font(.title)
                .fontWeight(.bold)

            Text(String(describing: error))
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Text("Please check the console logs for more details.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

enum AppInitializationError: Error {
    case modelContainerInitializationFailed(String)
    case noFeatureEnabled
}
