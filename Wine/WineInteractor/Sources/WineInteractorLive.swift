import Foundation
import SharedCommonDependencies
import WineDomain
import WineRepository

extension WineInteractor {
    static let live = WineInteractor(
        fetchAll: {
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAll().map { try $0.toDomain() }
            }
        },
        fetchAllWinemakers: { searchText in
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAllWinemakers(searchText).map { $0.toDomain() }
            }
        },
        fetchAllGrapeVarieties: { searchText in
            @Dependency(\.wineRepository) var repository

            return await withResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAllGrapeVarieties(searchText).map { $0.toDomain() }
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
        upsert: { domain in
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

            return await withResult(parser: WineInteractorError.init) {
                try await repository.upsert(domain.toEntity())
            }
        },
        upsertWinemaker: { winemaker in
            @Dependency(\.wineRepository) var repository

            guard !winemaker.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) {
                try await repository.upsertWinemaker(winemaker.toEntity())
            }
        },
        upsertGrapeVariety: { grapeVariety in
            @Dependency(\.wineRepository) var repository

            guard !grapeVariety.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withResult(parser: WineInteractorError.init) {
                try await repository.upsertGrapeVariety(grapeVariety.toEntity())
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
