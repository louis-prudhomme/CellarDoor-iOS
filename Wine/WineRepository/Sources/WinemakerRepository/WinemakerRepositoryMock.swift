import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

public extension WinemakerRepository {
    static func mock(
        fetchAll: @escaping @MainActor @Sendable (String) async throws -> [WinemakerEntity] = { _ in fatalError("Not mocked yet") },
        upsert: @escaping @MainActor @Sendable (WinemakerEntity) async throws -> WinemakerEntity = { _ in fatalError("Not mocked yet") }
    ) -> WinemakerRepository {
        WinemakerRepository(
            fetchAll: fetchAll,
            upsert: upsert
        )
    }
}
