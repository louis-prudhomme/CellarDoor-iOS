import Foundation
import Dependencies

public struct Wine: Equatable, Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let createdAt: Date

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}

public extension Wine {
    static func new(name: String) -> Wine {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        return Wine(id: uuid(), name: name, createdAt: date())
    }
}
