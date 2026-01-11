import SharedCommonDependencies

extension AppellationInteractor {
    static let mock = AppellationInteractor(
        search: { _ in fatalError("AppellationInteractor.search") },
        upsert: { _ in fatalError("AppellationInteractor.upsert") },
        fetchAllCountries: { fatalError("AppellationInteractor.fetchAllCountries") },
        fetchAllVineyards: { _ in fatalError("AppellationInteractor.fetchAllVineyards") },
        fetchAllRegions: { _ in fatalError("AppellationInteractor.fetchAllRegions") },
        upsertRegion: { _ in fatalError("AppellationInteractor.upsertRegion") },
        upsertVineyard: { _ in fatalError("AppellationInteractor.upsertVineyard") },
        upsertCountry: { _ in fatalError("AppellationInteractor.upsertCountry") }
    )
}
