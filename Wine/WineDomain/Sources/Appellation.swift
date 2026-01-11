import Dependencies
import Foundation
import SharedCommonDomain

public struct Appellation: Interactable {
    public let id: UUID
    public let name: String
    public let region: Region
    public let createdAt: Date

    public init(id: UUID, name: String, region: Region, createdAt: Date) {
        self.id = id
        self.name = name
        self.region = region
        self.createdAt = createdAt
    }
}

public extension Appellation {
    init(name: String, region: Region) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(id: uuid(), name: name, region: region, createdAt: date())
    }
}
