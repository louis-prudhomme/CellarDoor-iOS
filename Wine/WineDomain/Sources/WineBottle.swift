import Dependencies
import Foundation
import SharedCommonDomain

public struct WineBottle: Interactable {
    public let id: UUID
    public let name: String
    public let millesime: Int
    public let createdAt: Date
    public let winemaker: Winemaker?

    public init(id: UUID, name: String, millesime: Int, createdAt: Date, winemaker: Winemaker? = nil) {
        self.id = id
        self.name = name
        self.millesime = millesime
        self.createdAt = createdAt
        self.winemaker = winemaker
    }
}

public extension WineBottle {
    static func new(name: String, millesime: Int, winemaker: Winemaker? = nil) -> WineBottle {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        return WineBottle(id: uuid(), name: name, millesime: millesime, createdAt: date(), winemaker: winemaker)
    }
}
