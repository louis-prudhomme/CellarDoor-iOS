import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

public struct AppellationRepository: Sendable {
    public let base: BaseRepository<AppellationEntity>
    public let search: @MainActor @Sendable (String) async throws -> [AppellationEntity]
    public let fetchAllCountries: @MainActor @Sendable () async throws -> [CountryEntity]
    public let fetchAllVineyards: @MainActor @Sendable (UUID) async throws -> [VineyardEntity]
    public let fetchAllRegions: @MainActor @Sendable (UUID) async throws -> [RegionEntity]
    public let upsertRegion: @MainActor @Sendable (RegionEntity) async throws -> RegionEntity
    public let upsertVineyard: @MainActor @Sendable (VineyardEntity) async throws -> VineyardEntity
    public let upsertCountry: @MainActor @Sendable (CountryEntity) async throws -> CountryEntity
}

// MARK: - Convenience Accessors

public extension AppellationRepository {
    var fetchAll: @MainActor @Sendable () async throws -> [AppellationEntity] { base.fetchAll }
    var fetch: @MainActor @Sendable (UUID) async throws -> AppellationEntity? { base.fetch }
    var upsert: @MainActor @Sendable (AppellationEntity) async throws -> AppellationEntity { base.upsert }
    var delete: @MainActor @Sendable (UUID) async throws -> Void { base.delete }
}

// MARK: - Dependency Registration

extension AppellationRepository: DependencyKey {
    public static let liveValue = Self.live()
    public static let testValue = Self.mock()
    public static let previewValue = Self.mock()
}

public extension DependencyValues {
    var appellationRepository: AppellationRepository {
        get { self[AppellationRepository.self] }
        set { self[AppellationRepository.self] = newValue }
    }
}
