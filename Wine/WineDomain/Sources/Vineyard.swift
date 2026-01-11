import Dependencies
import Foundation
import SharedCommonDomain

public struct Vineyard: Interactable {
    public let id: UUID
    public let name: String
    public let country: Country
    public let createdAt: Date

    public init(id: UUID, name: String, country: Country, createdAt: Date) {
        self.id = id
        self.name = name
        self.country = country
        self.createdAt = createdAt
    }
}

public extension Vineyard {
    init(name: String, country: Country) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(id: uuid(), name: name, country: country, createdAt: date())
    }
}
