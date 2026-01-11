import Foundation
import SharedCommonDependencies
import WineDomain
import WineRepository

extension WineInteractor {
    private static func sharedUpsert(wineBottle domain: WineBottle) async -> Result<WineBottle, WineInteractorError> {
        @Dependency(\.wineRepository) var repository
        @Dependency(\.date) var date
        @Dependency(\.calendar) var calendar

        guard !domain.name.isEmpty else {
            return .failure(WineInteractorError.nameEmpty)
        }

        let currentYear = calendar.component(.year, from: date())
        guard domain.millesime <= currentYear else {
            return .failure(WineInteractorError.millesimeInvalid)
        }
        guard !domain.grapeVarieties.isEmpty else {
            return .failure(WineInteractorError.grapeVarietyEmpty)
        }
        guard domain.abv >= 0.0, domain.abv <= 100.0 else {
            return .failure(WineInteractorError.invalidAbv)
        }

        return await withResult(parser: WineInteractorError.init) { @MainActor in
            let entity = try await repository.upsert(domain.toEntity())
            return try entity.toDomain()
        }
    }

    static let live = WineInteractor(
        fetchAll: {
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAll().map { try $0.toDomain() }
            }
        },
        fetchAllWinemakers: { searchText in
            @Dependency(\.winemakerRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAll(searchText).map { $0.toDomain() }
            }
        },
        fetchAllGrapeVarieties: { searchText in
            @Dependency(\.grapeVarietyRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAll(searchText).map { $0.toDomain() }
            }
        },
        fetch: { id in
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                guard let entity = try await repository.fetch(id) else {
                    throw WineInteractorError.notFound
                }

                return try entity.toDomain()
            }
        },
        create: { partialWine in
            @Dependency(\.wineRepository) var repository
            @Dependency(\.date) var date
            @Dependency(\.calendar) var calendar

            guard let bottlingLocation = partialWine.bottlingLocation else {
                return .failure(WineInteractorError.bottlingLocationMissing)
            }
            guard let pictureData = partialWine.picture else {
                return .failure(WineInteractorError.pictureMissing)
            }

            let completeDomain = WineBottle(
                name: partialWine.name,
                millesime: partialWine.millesime,
                abv: partialWine.abv,
                picture: pictureData,
                bottlingLocation: bottlingLocation,
                grapeVarieties: partialWine.grapeVarieties,
                winemaker: partialWine.winemaker
            )
            return await sharedUpsert(wineBottle: completeDomain)
        },
        upsert: { domain in
            await sharedUpsert(wineBottle: domain)
        },
        upsertWinemaker: { winemaker in
            @Dependency(\.winemakerRepository) var repository

            guard !winemaker.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsert(winemaker.toEntity())
                return entity.toDomain()
            }
        },
        upsertGrapeVariety: { grapeVariety in
            @Dependency(\.grapeVarietyRepository) var repository

            guard !grapeVariety.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                let entity = try await repository.upsert(grapeVariety.toEntity())
                return entity.toDomain()
            }
        },
        delete: { id in
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) {
                try await repository.delete(id)
            }
        }
    )
}
