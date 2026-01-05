import Dependencies
import DependenciesAdditions
import Foundation
import WineDomain
import WineEntity

enum TestHelpers {
    static let testDate = Date(timeIntervalSince1970: 1_704_067_200) // 2024-01-01
    // swiftlint:disable:next force_unwrapping
    static let testID = UUID(uuidString: "12345678-1234-1234-1234-123456789012")!

    static func makeTestGrapeVarietyEntity() -> GrapeVarietyEntity {
        GrapeVarietyEntity(
            id: testID,
            name: "Pinot Noir",
            createdAt: testDate
        )
    }

    static func makeTestGrapeVariety() -> GrapeVariety {
        GrapeVariety(
            id: testID,
            name: "Pinot Noir",
            createdAt: testDate
        )
    }

    static func makeTestWinemakerEntity() -> WinemakerEntity {
        WinemakerEntity(
            id: testID,
            name: "Domaine de la Romanée-Conti",
            createdAt: testDate
        )
    }

    static func makeTestWinemaker() -> Winemaker {
        Winemaker(
            id: testID,
            name: "Domaine de la Romanée-Conti",
            createdAt: testDate
        )
    }

    static func makeTestBottlingLocationEntity() throws -> WineBottlingLocationEntity {
        let divisions = [
            WineBottlingLocation.AdministrativeDivision(type: .country, name: "France", code: "FR"),
            WineBottlingLocation.AdministrativeDivision(type: .region, name: "Burgundy", code: "BFC")
        ]

        return try withDependencies {
            $0.encode = DataEncoder.json
        } operation: {
            let encodedDivisions = try JSONEncoder().encode(divisions)

            return WineBottlingLocationEntity(
                id: testID,
                name: "Vosne-Romanée",
                latitude: 47.1611,
                longitude: 4.9589,
                countryCode: "FR",
                regionCode: "BFC",
                administrativeDivisions: encodedDivisions,
                providerId: 12345,
                createdAt: testDate
            )
        }
    }

    static func makeTestBottlingLocation() -> WineBottlingLocation {
        WineBottlingLocation(
            id: testID,
            name: "Vosne-Romanée",
            coordinates: WineBottlingLocation.GeographicalCoordinates(latitude: 47.1611, longitude: 4.9589),
            administrativeDivisions: [
                WineBottlingLocation.AdministrativeDivision(type: .country, name: "France", code: "FR"),
                WineBottlingLocation.AdministrativeDivision(type: .region, name: "Burgundy", code: "BFC")
            ],
            providerId: 12345,
            createdAt: testDate
        )
    }
}
