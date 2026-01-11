import Dependencies
import Foundation
import SharedCommonPersistence
import SwiftData
import WineEntity

public struct GrapeVarietyRepository: Sendable {
    public let fetchAll: @MainActor @Sendable (String) async throws -> [GrapeVarietyEntity]
    public let upsert: @MainActor @Sendable (GrapeVarietyEntity) async throws -> GrapeVarietyEntity
}

// MARK: - Dependency Registration

extension GrapeVarietyRepository: DependencyKey {
    public static let liveValue = Self.live()
    public static let testValue = Self.mock()
    public static let previewValue = Self.mock()
}

public extension DependencyValues {
    var grapeVarietyRepository: GrapeVarietyRepository {
        get { self[GrapeVarietyRepository.self] }
        set { self[GrapeVarietyRepository.self] = newValue }
    }
}
