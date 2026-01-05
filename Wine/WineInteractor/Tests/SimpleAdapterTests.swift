import Dependencies
import Testing
import WineDomain
import WineEntity
@testable import WineInteractor

@Suite("GrapeVariety Adapter Tests")
struct GrapeVarietyAdapterTests {
    @Test("GrapeVarietyEntity converts to GrapeVariety domain correctly")
    func grapeVarietyEntityToDomain() {
        let entity = TestHelpers.makeTestGrapeVarietyEntity()
        let domain = entity.toDomain()

        #expect(domain.id == TestHelpers.testID)
        #expect(domain.name == "Pinot Noir")
        #expect(domain.createdAt == TestHelpers.testDate)
    }

    @Test("GrapeVariety domain converts to GrapeVarietyEntity correctly")
    func grapeVarietyToEntity() {
        let domain = TestHelpers.makeTestGrapeVariety()
        let entity = domain.toEntity()

        #expect(entity.id == TestHelpers.testID)
        #expect(entity.name == "Pinot Noir")
        #expect(entity.createdAt == TestHelpers.testDate)
    }
}

@Suite("Winemaker Adapter Tests")
struct WinemakerAdapterTests {
    @Test("WinemakerEntity converts to Winemaker domain correctly")
    func winemakerEntityToDomain() {
        let entity = TestHelpers.makeTestWinemakerEntity()
        let domain = entity.toDomain()

        #expect(domain.id == TestHelpers.testID)
        #expect(domain.name == "Domaine de la Romanée-Conti")
        #expect(domain.createdAt == TestHelpers.testDate)
    }

    @Test("Winemaker domain converts to WinemakerEntity correctly")
    func winemakerToEntity() {
        let domain = TestHelpers.makeTestWinemaker()
        let entity = domain.toEntity()

        #expect(entity.id == TestHelpers.testID)
        #expect(entity.name == "Domaine de la Romanée-Conti")
        #expect(entity.createdAt == TestHelpers.testDate)
    }
}
