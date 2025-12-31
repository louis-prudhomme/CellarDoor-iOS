import Dependencies
import SharedCommonInteractor

extension WineInteractor {
    static let mock = WineInteractor(
        fetchAll: { fatalError("WineInteractor.fetchAll") },
        fetchAllWinemakers: { _ in fatalError("WineInteractor.fetchAllWinemakers") },
        fetch: { _ in fatalError("WineInteractor.fetch") },
        upsert: { _ in fatalError("WineInteractor.upsert") },
        upsertWinemaker: { _ in fatalError("WineInteractor.upsertWinemaker") },
        delete: { _ in fatalError("WineInteractor.delete") }
    )
}
