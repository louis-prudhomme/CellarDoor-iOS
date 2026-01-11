import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

public extension AppellationRepository {
    static func mock(
        base: BaseRepository<AppellationEntity> = .mock(),
        search: @escaping @MainActor @Sendable (String) async throws -> [AppellationEntity] = { _ in fatalError("Not mocked yet") },
    fetchAllCountries: @escaping @MainActor @Sendable () async throws -> [CountryEntity] = { fatalError("Not mocked yet") },
    fetchAllVineyards: @escaping @MainActor @Sendable (UUID) async throws -> [VineyardEntity] = { _ in fatalError("Not mocked yet") },
    fetchAllRegions: @escaping @MainActor @Sendable (UUID) async throws -> [RegionEntity] = { _ in fatalError("Not mocked yet") },
        upsertRegion: @escaping @MainActor @Sendable (RegionEntity) async throws -> RegionEntity = { _ in fatalError("Not mocked yet") },
        upsertVineyard: @escaping @MainActor @Sendable (VineyardEntity) async throws -> VineyardEntity = { _ in fatalError("Not mocked yet") },
        upsertCountry: @escaping @MainActor @Sendable (CountryEntity) async throws -> CountryEntity = { _ in fatalError("Not mocked yet") }
    ) -> AppellationRepository {
        AppellationRepository(
            base: base,
            search: search,
            fetchAllCountries: fetchAllCountries,
            fetchAllVineyards: fetchAllVineyards,
            fetchAllRegions: fetchAllRegions,
            upsertRegion: upsertRegion,
            upsertVineyard: upsertVineyard,
            upsertCountry: upsertCountry
        )
    }
}
