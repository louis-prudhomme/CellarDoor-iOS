import Foundation
import SharedCommonDependencies
import WineDomain
import WineRepository

extension AppellationInteractor {
    static let live = AppellationInteractor(
        search: { searchText in
            @Dependency(\.appellationRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.search(searchText).map { try $0.toDomain() }
            }
        },
        upsert: { appellation in
            @Dependency(\.appellationRepository) var repository

            guard !appellation.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsert(appellation.toEntity())
                return try entity.toDomain()
            }
        },
        fetchAllCountries: {
            @Dependency(\.appellationRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAllCountries().map { $0.toDomain() }
            }
        },
        fetchAllVineyards: { countryId in
            @Dependency(\.appellationRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAllVineyards(countryId).map { try $0.toDomain() }
            }
        },
        fetchAllRegions: { vineyardId in
            @Dependency(\.appellationRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAllRegions(vineyardId).map { try $0.toDomain() }
            }
        },
        upsertRegion: { region in
            @Dependency(\.appellationRepository) var repository

            guard !region.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsertRegion(region.toEntity())
                return try entity.toDomain()
            }
        },
        upsertVineyard: { vineyard in
            @Dependency(\.appellationRepository) var repository

            guard !vineyard.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsertVineyard(vineyard.toEntity())
                return try entity.toDomain()
            }
        },
        upsertCountry: { country in
            @Dependency(\.appellationRepository) var repository

            guard !country.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsertCountry(country.toEntity())
                return entity.toDomain()
            }
        }
    )
}
