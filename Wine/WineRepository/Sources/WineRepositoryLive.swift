import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

// CRUD operations are already provided by BaseRepository

public extension WineRepository {
    static func live(
        base: BaseRepository<WineBottleEntity> = .live(),
    ) -> WineRepository {
        WineRepository(
            base: base
        )
    }
}
