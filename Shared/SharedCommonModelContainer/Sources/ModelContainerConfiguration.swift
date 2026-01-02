import SwiftData
import WineEntity

public enum ModelContainerConfiguration {
    /// All @Model types registered in the app.
    public static let modelTypes: [any PersistentModel.Type] = [
        WineBottleEntity.self,
        WinemakerEntity.self
    ]

    /// Creates a configured ModelContainer with all registered models
    /// - Parameter inMemory: If true, uses in-memory storage (for previews/tests)
    /// - Returns: Configured ModelContainer
    public static func makeContainer(inMemory: Bool = false) throws -> ModelContainer {
        let schema = Schema(modelTypes)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        return try ModelContainer(for: schema, configurations: configuration)
    }

    public static func initialize() throws -> ModelContainer {
        return try makeContainer(inMemory: false)
    }

    public static func initializeForTesting() throws -> ModelContainer {
        return try makeContainer(inMemory: true)
    }
}
