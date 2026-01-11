import Dependencies
import Foundation
import SharedCommonDomain

public struct WineBottle: Interactable {
    public let id: UUID
    public let name: String
    public let millesime: Int
    public let abv: Double
    public let picture: Data
    public let bottlingLocation: WineBottlingLocation
    public let createdAt: Date
    public let winemaker: Winemaker? // TODO: a wine can probably have several winemakers
    public let grapeVarieties: [GrapeVariety]
    public let appellation: Appellation

    public init(id: UUID, name: String, millesime: Int, abv: Double, picture: Data, bottlingLocation: WineBottlingLocation, grapeVarieties: [GrapeVariety], winemaker: Winemaker?, appellation: Appellation, createdAt: Date) {
        self.id = id
        self.name = name
        self.millesime = millesime
        self.abv = abv
        self.picture = picture
        self.bottlingLocation = bottlingLocation
        self.winemaker = winemaker
        self.grapeVarieties = grapeVarieties
        self.appellation = appellation
        self.createdAt = createdAt
    }
}

public extension WineBottle {
    init(name: String, millesime: Int, abv: Double, picture: Data, bottlingLocation: WineBottlingLocation, grapeVarieties: [GrapeVariety], winemaker: Winemaker? = nil, appellation: Appellation? = nil) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(
            id: uuid(),
            name: name,
            millesime: millesime,
            abv: abv,
            picture: picture,
            bottlingLocation: bottlingLocation,
            grapeVarieties: grapeVarieties,
            winemaker: winemaker,
            appellation: appellation,
            createdAt: date()
        )
    }
}
