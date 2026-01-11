import Foundation
import SharedCommonDependencies
import WineDomain

public struct AppellationInteractor: Sendable {
    public var search: @Sendable (String) async -> Result<[Appellation], WineInteractorError>
    public var upsert: @Sendable (Appellation) async -> Result<Appellation, WineInteractorError>
    public var fetchAllCountries: @Sendable () async -> Result<[Country], WineInteractorError>
    public var fetchAllVineyards: @Sendable (UUID) async -> Result<[Vineyard], WineInteractorError>
    public var fetchAllRegions: @Sendable (UUID) async -> Result<[Region], WineInteractorError>
    public var upsertRegion: @Sendable (Region) async -> Result<Region, WineInteractorError>
    public var upsertVineyard: @Sendable (Vineyard) async -> Result<Vineyard, WineInteractorError>
    public var upsertCountry: @Sendable (Country) async -> Result<Country, WineInteractorError>

    public init(
        search: @escaping @Sendable (String) async -> Result<[Appellation], WineInteractorError>,
        upsert: @escaping @Sendable (Appellation) async -> Result<Appellation, WineInteractorError>,
        fetchAllCountries: @escaping @Sendable () async -> Result<[Country], WineInteractorError>,
        fetchAllVineyards: @escaping @Sendable (UUID) async -> Result<[Vineyard], WineInteractorError>,
        fetchAllRegions: @escaping @Sendable (UUID) async -> Result<[Region], WineInteractorError>,
        upsertRegion: @escaping @Sendable (Region) async -> Result<Region, WineInteractorError>,
        upsertVineyard: @escaping @Sendable (Vineyard) async -> Result<Vineyard, WineInteractorError>,
        upsertCountry: @escaping @Sendable (Country) async -> Result<Country, WineInteractorError>
    ) {
        self.search = search
        self.upsert = upsert
        self.fetchAllCountries = fetchAllCountries
        self.fetchAllVineyards = fetchAllVineyards
        self.fetchAllRegions = fetchAllRegions
        self.upsertRegion = upsertRegion
        self.upsertVineyard = upsertVineyard
        self.upsertCountry = upsertCountry
    }
}

// MARK: - Dependency Registration

extension AppellationInteractor: DependencyKey {
    public static let liveValue = AppellationInteractor.live
    public static let testValue = AppellationInteractor.mock
    public static let previewValue = AppellationInteractor.mock
}

public extension DependencyValues {
    var appellationInteractor: AppellationInteractor {
        get { self[AppellationInteractor.self] }
        set { self[AppellationInteractor.self] = newValue }
    }
}
