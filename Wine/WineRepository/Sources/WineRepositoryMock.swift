import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

public extension WineRepository {
    static func mock(
        base: BaseRepository<WineBottleEntity> = .mock(),
    ) -> WineRepository {
        WineRepository(
            base: base,
            fetchAllWinemakers: { _ in fatalError("Not mocked yet") },
            upsertWinemaker: { _ in fatalError("Not mocked yet") }
        )
    }
}
