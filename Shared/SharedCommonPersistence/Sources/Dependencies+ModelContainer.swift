import Dependencies
import SwiftData

public extension DependencyValues {
    /// The shared ModelContainer for SwiftData persistence.
    /// Initialize this in your app's entry point with all your @Model types.
    var modelContainer: ModelContainer {
        get { self[ModelContainerKey.self] }
        set { self[ModelContainerKey.self] = newValue }
    }
}

private enum ModelContainerKey: DependencyKey {
    static let liveValue: ModelContainer = {
        fatalError(
            """
            ModelContainer not initialized. Set it up in your app's entry point:

            import SharedCommonModelContainer

            @main
            struct YourApp: App {
                init() {
                    ModelContainerConfiguration.initialize()
                }

                var body: some Scene { ... }
            }

            Make sure all @Model types are registered in SharedCommonModelContainer.
            """
        )
    }()

    static let testValue: ModelContainer = try! ModelContainer(
        for: Schema([]),
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
}
