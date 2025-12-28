import Dependencies
import SharedCommonInteractor
import WineRepository

extension WineInteractor {
    static let live = WineInteractor(
        fetchAll: {
            @Dependency(\.wineRepository) var repository

            return await withInteractorResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetchAll().map { $0.toDomain() }
            }
        },
        fetch: { id in
            @Dependency(\.wineRepository) var repository

            return await withInteractorResult(parser: WineInteractorError.init) { @MainActor in
                try await repository.fetch(id)
            }.flatMap { entity in
                guard let entity else {
                    return .failure(WineInteractorError.notFound)
                }
                return .success(entity.toDomain())
            }
        },
        upsert: { domain in
            @Dependency(\.wineRepository) var repository

            guard !domain.name.isEmpty else {
                return .failure(WineInteractorError.nameEmpty)
            }

            return await withInteractorResult(parser: WineInteractorError.init) {
                try await repository.upsert(domain.toEntity())
            }
        },
        delete: { id in
            @Dependency(\.wineRepository) var repository
            
            return await withInteractorResult(parser: WineInteractorError.init) {
                try await repository.delete(id)
            }
        }
    )
}
