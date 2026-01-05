import Dependencies
import DependenciesAdditions
import Foundation
import Testing
import WineDomain
import WineEntity
@testable import WineInteractor

@Suite("WineBottlingLocation Adapter Tests")
struct BottlingLocationAdapterTests {
    @Test("WineBottlingLocationEntity converts to WineBottlingLocation domain correctly")
    func bottlingLocationEntityToDomain() throws {
        let entity = try TestHelpers.makeTestBottlingLocationEntity()

        let domain = try withDependencies {
            $0.decode = DataDecoder.json
        } operation: {
            try entity.toDomain()
        }

        #expect(domain.id == TestHelpers.testID)
        #expect(domain.name == "Vosne-Romanée")
        #expect(domain.coordinates.latitude == 47.1611)
        #expect(domain.coordinates.longitude == 4.9589)
        #expect(domain.providerId == 12345)
        #expect(domain.createdAt == TestHelpers.testDate)
        #expect(domain.administrativeDivisions.count == 2)
        #expect(domain.administrativeDivisions[0].type == .country)
        #expect(domain.administrativeDivisions[0].name == "France")
        #expect(domain.administrativeDivisions[0].code == "FR")
        #expect(domain.administrativeDivisions[1].type == .region)
        #expect(domain.administrativeDivisions[1].name == "Burgundy")
        #expect(domain.administrativeDivisions[1].code == "BFC")
    }

    @Test("WineBottlingLocation domain converts to WineBottlingLocationEntity correctly")
    func bottlingLocationToEntity() throws {
        let domain = TestHelpers.makeTestBottlingLocation()

        let entity = try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            try domain.toEntity()
        }

        #expect(entity.id == TestHelpers.testID)
        #expect(entity.name == "Vosne-Romanée")
        #expect(entity.latitude == 47.1611)
        #expect(entity.longitude == 4.9589)
        #expect(entity.countryCode == "FR")
        #expect(entity.regionCode == "BFC")
        #expect(entity.providerId == 12345)
        #expect(entity.createdAt == TestHelpers.testDate)

        let decodedDivisions = try JSONDecoder().decode(
            [WineBottlingLocation.AdministrativeDivision].self,
            from: entity.administrativeDivisions
        )
        #expect(decodedDivisions.count == 2)
        #expect(decodedDivisions[0].type == .country)
        #expect(decodedDivisions[1].type == .region)
    }

    @Test("WineBottlingLocationEntity with invalid JSON throws error")
    func bottlingLocationEntityWithInvalidDataThrows() throws {
        let entity = WineBottlingLocationEntity(
            id: TestHelpers.testID,
            name: "Test",
            latitude: 0,
            longitude: 0,
            countryCode: "FR",
            regionCode: nil,
            administrativeDivisions: Data([0x00, 0x01]),
            providerId: 123,
            createdAt: TestHelpers.testDate
        )

        #expect(throws: WineInteractorError.self) {
            try withDependencies {
                $0.decode = DataDecoder.json
            } operation: {
                try entity.toDomain()
            }
        }
    }
}
