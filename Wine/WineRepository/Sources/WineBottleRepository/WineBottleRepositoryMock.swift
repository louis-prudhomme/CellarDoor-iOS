import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

public extension WineRepository {
    static func mock(
        base: BaseRepository<WineBottleEntity> = .mock()
    ) -> WineRepository {
        WineRepository(base: base)
    }
}
