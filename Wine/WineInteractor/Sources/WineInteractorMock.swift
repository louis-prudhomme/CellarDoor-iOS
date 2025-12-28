import Dependencies
import SharedCommonInteractor

extension WineInteractor {
    static let mock = WineInteractor(
        fetchAll: { fatalError("WineInteractor.fetchAll") },
        fetch: { _ in fatalError("WineInteractor.fetch") },
        upsert: { _ in fatalError("WineInteractor.upsert") },
        delete: { _ in fatalError("WineInteractor.delete") }
    )
}
