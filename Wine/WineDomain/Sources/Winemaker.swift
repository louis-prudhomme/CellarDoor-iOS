import Foundation
import Dependencies

public struct Winemaker: Equatable, Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let createdAt: Date

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}

public extension Winemaker {
    static func new(name: String) -> Winemaker {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        return Winemaker(id: uuid(), name: name, createdAt: date())
    }
}
