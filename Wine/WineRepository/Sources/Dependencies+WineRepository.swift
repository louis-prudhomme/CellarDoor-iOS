import Dependencies
import Foundation
import SwiftData
import SharedCommonPersistence
import WineEntity

public struct WineRepository: Sendable {
    public let base: BaseRepository<WineBottleEntity>

    // Add custom operations here as needed:
    // public var fetchByCategory: @Sendable (String) async throws -> [WineBottleEntity]
}

// MARK: - Convenience Accessors

public extension WineRepository {
    var fetchAll: @MainActor @Sendable () async throws -> [WineBottleEntity] { base.fetchAll }
    var fetch: @MainActor @Sendable (UUID) async throws -> WineBottleEntity? { base.fetch }
    var upsert: @MainActor @Sendable (WineBottleEntity) async throws -> Void { base.upsert }
    var delete: @MainActor @Sendable (UUID) async throws -> Void { base.delete }
}

// MARK: - Dependency Registration

extension WineRepository: DependencyKey {
    public static let liveValue = Self.live()
    public static let testValue = Self.mock()
    public static let previewValue = Self.mock()
}

public extension DependencyValues {
    var wineRepository: WineRepository {
        get { self[WineRepository.self] }
        set { self[WineRepository.self] = newValue }
    }
}
