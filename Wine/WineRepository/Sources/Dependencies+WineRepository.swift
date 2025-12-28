import Dependencies
import Foundation
import SwiftData
import SharedCommonPersistence
import WineEntity

public struct WineRepository: Sendable {
    public let base: BaseRepository<WineEntity>

    // Add custom operations here as needed:
    // public var fetchByCategory: @Sendable (String) async throws -> [WineEntity]
}

// MARK: - Convenience Accessors

public extension WineRepository {
    var fetchAll: @MainActor @Sendable () async throws -> [WineEntity] { base.fetchAll }
    var fetch: @MainActor @Sendable (UUID) async throws -> WineEntity? { base.fetch }
    var upsert: @MainActor @Sendable (WineEntity) async throws -> Void { base.upsert }
    var delete: @MainActor @Sendable (UUID) async throws -> Void { base.delete }
}

// MARK: - Dependency Registration

extension WineRepository: DependencyKey {
    public static let liveValue = WineRepository(base: .live())
    public static let testValue = WineRepository(base: .mock())
    public static let previewValue = WineRepository(base: .mock())
}

public extension DependencyValues {
    var wineRepository: WineRepository {
        get { self[WineRepository.self] }
        set { self[WineRepository.self] = newValue }
    }
}
