import Foundation
import Dependencies

public struct WineBottle: Equatable, Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let createdAt: Date

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}

public extension WineBottle {
    static func new(name: String) -> WineBottle {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        return WineBottle(id: uuid(), name: name, createdAt: date())
    }
}
