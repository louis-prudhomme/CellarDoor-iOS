import Dependencies
import Foundation
import SharedCommonDomain

public struct WineBottle: Interactable {
    public let id: UUID
    public let name: String
    public let millesime: Int
    public let abv: Double
    public let bottlingLocation: WineBottlingLocation
    public let createdAt: Date
    public let winemaker: Winemaker?
    public let grapeVarieties: [GrapeVariety]

    public init(id: UUID, name: String, millesime: Int, abv: Double, bottlingLocation: WineBottlingLocation, grapeVarieties: [GrapeVariety], createdAt: Date, winemaker: Winemaker? = nil) {
        self.id = id
        self.name = name
        self.millesime = millesime
        self.abv = abv
        self.bottlingLocation = bottlingLocation
        self.createdAt = createdAt
        self.winemaker = winemaker
        self.grapeVarieties = grapeVarieties
    }
}

public extension WineBottle {
    init(name: String, millesime: Int, abv: Double, bottlingLocation: WineBottlingLocation, grapeVarieties: [GrapeVariety], winemaker: Winemaker? = nil) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(
            id: uuid(),
            name: name,
            millesime: millesime,
            abv: abv,
            bottlingLocation: bottlingLocation,
            grapeVarieties: grapeVarieties,
            createdAt: date(),
            winemaker: winemaker
        )
    }
}
