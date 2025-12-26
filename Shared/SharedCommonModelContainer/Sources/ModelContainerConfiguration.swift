import SwiftData
import WineEntity

/// Central configuration for models
public enum ModelContainerConfiguration {
    /// All @Model types registered in the app.
    public static let modelTypes: [any PersistentModel.Type] = [
        WineEntity.self
    ]
    
    /// Creates a configured ModelContainer with all registered models
    /// - Parameter inMemory: If true, uses in-memory storage (for previews/tests)
    /// - Returns: Configured ModelContainer
    public static func makeContainer(inMemory: Bool = false) throws -> ModelContainer {
        let schema = Schema(modelTypes)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        return try ModelContainer(for: schema, configurations: configuration)
    }
    
    /// Initializes the shared ModelContainer dependency
    public static func initialize() -> ModelContainer {
        let container = try! makeContainer(inMemory: false)
        return container
    }
    
    /// Initializes an in-memory ModelContainer for previews/tests
    public static func initializeForTesting() -> ModelContainer {
        let container = try! makeContainer(inMemory: true)
        return container
    }
}
