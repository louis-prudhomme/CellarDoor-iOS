import Dependencies
import DependenciesAdditions
import Foundation
import Testing
import WineDomain
import WineEntity
@testable import WineInteractor

@Suite("WineBottle Adapter Tests")
struct WineBottleAdapterTests {
    @Test("WineBottleEntity converts to WineBottle domain correctly")
    func wineBottleEntityToDomain() throws {
        let grapeEntity = TestHelpers.makeTestGrapeVarietyEntity()
        let winemakerEntity = TestHelpers.makeTestWinemakerEntity()
        let locationEntity = try TestHelpers.makeTestBottlingLocationEntity()

        let entity = WineBottleEntity(
            id: TestHelpers.testID,
            name: "Romanée-Conti Grand Cru",
            millesime: 2019,
            abv: 13.5,
            bottlingLocation: locationEntity,
            grapeVarieties: [grapeEntity],
            createdAt: TestHelpers.testDate,
            winemaker: winemakerEntity
        )

        let domain = try withDependencies {
            $0.decode = DataDecoder.json
        } operation: {
            try entity.toDomain()
        }

        #expect(domain.id == TestHelpers.testID)
        #expect(domain.name == "Romanée-Conti Grand Cru")
        #expect(domain.millesime == 2019)
        #expect(domain.abv == 13.5)
        #expect(domain.createdAt == TestHelpers.testDate)
        #expect(domain.grapeVarieties.count == 1)
        #expect(domain.grapeVarieties[0].name == "Pinot Noir")
        #expect(domain.winemaker?.name == "Domaine de la Romanée-Conti")
        #expect(domain.bottlingLocation.name == "Vosne-Romanée")
    }

    @Test("WineBottleEntity without winemaker converts correctly")
    func wineBottleEntityWithoutWinemakerToDomain() throws {
        let grapeEntity = TestHelpers.makeTestGrapeVarietyEntity()
        let locationEntity = try TestHelpers.makeTestBottlingLocationEntity()

        let entity = WineBottleEntity(
            id: TestHelpers.testID,
            name: "Test Wine",
            millesime: 2020,
            abv: 12.0,
            bottlingLocation: locationEntity,
            grapeVarieties: [grapeEntity],
            createdAt: TestHelpers.testDate,
            winemaker: nil
        )

        let domain = try withDependencies {
            $0.decode = DataDecoder.json
        } operation: {
            try entity.toDomain()
        }

        #expect(domain.winemaker == nil)
    }

    @Test("WineBottle domain converts to WineBottleEntity correctly")
    func wineBottleToEntity() throws {
        let grape = TestHelpers.makeTestGrapeVariety()
        let winemaker = TestHelpers.makeTestWinemaker()
        let location = TestHelpers.makeTestBottlingLocation()

        let domain = WineBottle(
            id: TestHelpers.testID,
            name: "Romanée-Conti Grand Cru",
            millesime: 2019,
            abv: 13.5,
            bottlingLocation: location,
            grapeVarieties: [grape],
            winemaker: winemaker,
            createdAt: TestHelpers.testDate
        )

        let entity = try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            try domain.toEntity()
        }

        #expect(entity.id == TestHelpers.testID)
        #expect(entity.name == "Romanée-Conti Grand Cru")
        #expect(entity.millesime == 2019)
        #expect(entity.abv == 13.5)
        #expect(entity.createdAt == TestHelpers.testDate)
        #expect(entity.grapeVarieties.count == 1)
        #expect(entity.grapeVarieties[0].name == "Pinot Noir")
        #expect(entity.winemaker?.name == "Domaine de la Romanée-Conti")
        #expect(entity.bottlingLocation.name == "Vosne-Romanée")
    }

    @Test("WineBottle domain without winemaker converts correctly")
    func wineBottleWithoutWinemakerToEntity() throws {
        let grape = TestHelpers.makeTestGrapeVariety()
        let location = TestHelpers.makeTestBottlingLocation()

        let domain = WineBottle(
            id: TestHelpers.testID,
            name: "Test Wine",
            millesime: 2020,
            abv: 12.0,
            bottlingLocation: location,
            grapeVarieties: [grape],
            winemaker: nil,
            createdAt: TestHelpers.testDate
        )

        let entity = try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            try domain.toEntity()
        }

        #expect(entity.winemaker == nil)
    }

    @Test("WineBottle full round-trip conversion maintains data integrity")
    func wineBottleRoundTrip() throws {
        let originalDomain = WineBottle(
            id: TestHelpers.testID,
            name: "Test Wine",
            millesime: 2021,
            abv: 14.0,
            bottlingLocation: TestHelpers.makeTestBottlingLocation(),
            grapeVarieties: [TestHelpers.makeTestGrapeVariety()],
            winemaker: TestHelpers.makeTestWinemaker(),
            createdAt: TestHelpers.testDate
        )

        let entity = try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            try originalDomain.toEntity()
        }

        let convertedDomain = try withDependencies {
            $0.decode = DataDecoder.json
        } operation: {
            try entity.toDomain()
        }

        #expect(convertedDomain.id == originalDomain.id)
        #expect(convertedDomain.name == originalDomain.name)
        #expect(convertedDomain.millesime == originalDomain.millesime)
        #expect(convertedDomain.abv == originalDomain.abv)
        #expect(convertedDomain.bottlingLocation.name == originalDomain.bottlingLocation.name)
        #expect(convertedDomain.grapeVarieties.count == originalDomain.grapeVarieties.count)
        #expect(convertedDomain.winemaker?.name == originalDomain.winemaker?.name)
    }

    @Test("Multiple grape varieties convert correctly")
    func multipleGrapeVarieties() throws {
        // swiftlint:disable:next force_unwrapping
        let id1 = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
        // swiftlint:disable:next force_unwrapping
        let id2 = UUID(uuidString: "22222222-2222-2222-2222-222222222222")!

        let grapes = [
            GrapeVariety(id: id1, name: "Pinot Noir", createdAt: TestHelpers.testDate),
            GrapeVariety(id: id2, name: "Chardonnay", createdAt: TestHelpers.testDate)
        ]

        let domain = WineBottle(
            id: TestHelpers.testID,
            name: "Blend",
            millesime: 2020,
            abv: 13.0,
            bottlingLocation: TestHelpers.makeTestBottlingLocation(),
            grapeVarieties: grapes,
            winemaker: nil,
            createdAt: TestHelpers.testDate
        )

        let entity = try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            try domain.toEntity()
        }

        #expect(entity.grapeVarieties.count == 2)
        #expect(entity.grapeVarieties[0].name == "Pinot Noir")
        #expect(entity.grapeVarieties[1].name == "Chardonnay")
    }
}
