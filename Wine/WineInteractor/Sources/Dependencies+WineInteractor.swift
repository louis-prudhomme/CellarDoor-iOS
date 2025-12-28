import Dependencies
import Foundation
import SharedCommonInteractor
import WineDomain

public struct WineInteractor: Sendable {
    public var fetchAll: @Sendable () async -> Result<[Wine], WineInteractorError>
    public var fetch: @Sendable (UUID) async -> Result<Wine, WineInteractorError>
    public var upsert: @Sendable (Wine) async -> VoidResult<WineInteractorError>
    public var delete: @Sendable (UUID) async -> VoidResult<WineInteractorError>

    public init(
        fetchAll: @escaping @Sendable () async -> Result<[Wine], WineInteractorError>,
        fetch: @escaping @Sendable (UUID) async -> Result<Wine, WineInteractorError>,
        upsert: @escaping @Sendable (Wine) async -> VoidResult<WineInteractorError>,
        delete: @escaping @Sendable (UUID) async -> VoidResult<WineInteractorError>
    ) {
        self.fetchAll = fetchAll
        self.fetch = fetch
        self.upsert = upsert
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