import Dependencies
import Foundation
import SharedCommonDomain

public struct Region: Interactable {
    public let id: UUID
    public let name: String
    public let vineyard: Vineyard
    public let createdAt: Date

    public init(id: UUID, name: String, vineyard: Vineyard, createdAt: Date) {
        self.id = id
        self.name = name
        self.vineyard = vineyard
        self.createdAt = createdAt
    }
}

public extension Region {
    init(name: String, vineyard: Vineyard) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(id: uuid(), name: name, vineyard: vineyard, createdAt: date())
    }
}
