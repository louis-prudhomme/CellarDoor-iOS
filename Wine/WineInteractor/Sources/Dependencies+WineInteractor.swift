import Dependencies
import Foundation
import SharedCommonInteractor
import WineDomain

public struct WineInteractor: Sendable {
    public var fetchAll: @Sendable () async -> Result<[WineBottle], WineInteractorError>
    public var fetchAllWinemakers: @Sendable (String) async -> Result<[Winemaker], WineInteractorError>
    public var fetch: @Sendable (UUID) async -> Result<WineBottle, WineInteractorError>
    public var upsert: @Sendable (WineBottle) async -> VoidResult<WineInteractorError>
    public var upsertWinemaker: @Sendable (Winemaker) async -> VoidResult<WineInteractorError>
    public var delete: @Sendable (UUID) async -> VoidResult<WineInteractorError>

    public init(
        fetchAll: @escaping @Sendable () async -> Result<[WineBottle], WineInteractorError>,
        fetchAllWinemakers: @escaping @Sendable (String) async -> Result<[Winemaker], WineInteractorError>,
        fetch: @escaping @Sendable (UUID) async -> Result<WineBottle, WineInteractorError>,
        upsert: @escaping @Sendable (WineBottle) async -> VoidResult<WineInteractorError>,
        upsertWinemaker: @escaping @Sendable (Winemaker) async -> VoidResult<WineInteractorError>,
        delete: @escaping @Sendable (UUID) async -> VoidResult<WineInteractorError>
    ) {
        self.fetchAll = fetchAll
        self.fetchAllWinemakers = fetchAllWinemakers
        self.fetch = fetch
        self.upsert = upsert
        self.upsertWinemaker = upsertWinemaker
        self.delete = delete
    }
}

// MARK: - Dependency Registration

extension WineInteractor: DependencyKey {
    public static let liveValue: WineInteractor = .live
    public static let testValue: WineInteractor = .mock
    public static let previewValue: WineInteractor = .mock
}

public extension DependencyValues {
    var wineInteractor: WineInteractor {
        get { self[WineInteractor.self] }
        set { self[WineInteractor.self] = newValue }
    }
}
