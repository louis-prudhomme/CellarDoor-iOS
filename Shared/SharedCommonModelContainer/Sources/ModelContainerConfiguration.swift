import Dependencies
import SwiftData
import WineEntity

// TODO: although placed SharedCommonModelContainer, this is the Wine app's => have a dynamic implementation per app
public struct ModelContainerConfigurator: Sendable {
    public var initialize: @Sendable () throws -> ModelContainer

    /// All @Model types registered in the app.
    private static let modelTypes: [any PersistentModel.Type] = [
        WineBottleEntity.self,
        WinemakerEntity.self,
        GrapeVarietyEntity.self,
        WineBottlingLocationEntity.self,
        AppellationEntity.self,
        RegionEntity.self,
        VineyardEntity.self,
        CountryEntity.self
    ]

    private static func makeContainer(inMemory: Bool = false) throws -> ModelContainer {
        let schema = Schema(modelTypes)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        return try ModelContainer(for: schema, configurations: configuration)
    }
}

extension ModelContainerConfigurator: DependencyKey {
    public static let liveValue = ModelContainerConfigurator {
        try makeContainer(inMemory: false)
    }

    public static let testValue = ModelContainerConfigurator {
        try makeContainer(inMemory: true)
    }
}

public extension DependencyValues {
    var modelContainerConfigurator: ModelContainerConfigurator {
        get { self[ModelContainerConfigurator.self] }
        set { self[ModelContainerConfigurator.self] = newValue }
    }
}
