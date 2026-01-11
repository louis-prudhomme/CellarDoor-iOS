import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

public struct WinemakerRepository: Sendable {
    public let fetchAll: @MainActor @Sendable (String) async throws -> [WinemakerEntity]
    public let upsert: @MainActor @Sendable (WinemakerEntity) async throws -> WinemakerEntity
}

// MARK: - Dependency Registration

extension WinemakerRepository: DependencyKey {
    public static let liveValue = Self.live()
    public static let testValue = Self.mock()
    public static let previewValue = Self.mock()
}

public extension DependencyValues {
    var winemakerRepository: WinemakerRepository {
        get { self[WinemakerRepository.self] }
        set { self[WinemakerRepository.self] = newValue }
    }
}
