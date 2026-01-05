import Foundation
import Testing
import WineDomain
@testable import WineInteractor

@Suite("AdministrativeDivision Codable Tests")
struct AdministrativeDivisionCodableTests {
    @Test("AdministrativeDivision with country type encodes and decodes correctly")
    func administrativeDivisionCountryCodable() throws {
        let division = WineBottlingLocation.AdministrativeDivision(
            type: .country,
            name: "France",
            code: "FR"
        )

        let encoded = try JSONEncoder().encode(division)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.self,
            from: encoded
        )

        #expect(decoded.type == .country)
        #expect(decoded.name == "France")
        #expect(decoded.code == "FR")
    }

    @Test("AdministrativeDivision with region type encodes and decodes correctly")
    func administrativeDivisionRegionCodable() throws {
        let division = WineBottlingLocation.AdministrativeDivision(
            type: .region,
            name: "Burgundy",
            code: "BFC"
        )

        let encoded = try JSONEncoder().encode(division)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.self,
            from: encoded
        )

        #expect(decoded.type == .region)
        #expect(decoded.name == "Burgundy")
        #expect(decoded.code == "BFC")
    }

    @Test("AdministrativeDivision with countyOrSmaller type encodes and decodes correctly")
    func administrativeDivisionCountyCodable() throws {
        let division = WineBottlingLocation.AdministrativeDivision(
            type: .countyOrSmaller(2),
            name: "Côte-d'Or",
            code: "21"
        )

        let encoded = try JSONEncoder().encode(division)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.self,
            from: encoded
        )

        #expect(decoded.type == .countyOrSmaller(2))
        #expect(decoded.name == "Côte-d'Or")
        #expect(decoded.code == "21")
    }
}

@Suite("DivisionType Codable Tests")
struct DivisionTypeCodableTests {
    @Test("DivisionType encodes country correctly")
    func divisionTypeCountryEncoding() throws {
        let type = WineBottlingLocation.AdministrativeDivision.DivisionType.country
        let encoded = try JSONEncoder().encode(type)
        let json = String(data: encoded, encoding: .utf8)

        #expect(json == "\"country\"")
    }

    @Test("DivisionType encodes region correctly")
    func divisionTypeRegionEncoding() throws {
        let type = WineBottlingLocation.AdministrativeDivision.DivisionType.region
        let encoded = try JSONEncoder().encode(type)
        let json = String(data: encoded, encoding: .utf8)

        #expect(json == "\"region\"")
    }

    @Test("DivisionType encodes countyOrSmaller correctly")
    func divisionTypeCountyEncoding() throws {
        let type = WineBottlingLocation.AdministrativeDivision.DivisionType.countyOrSmaller(3)
        let encoded = try JSONEncoder().encode(type)
        let json = String(data: encoded, encoding: .utf8)

        #expect(json == "\"countyOrSmaller_3\"")
    }

    @Test("DivisionType decodes country correctly")
    func divisionTypeCountryDecoding() throws {
        let json = Data("\"country\"".utf8)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.DivisionType.self,
            from: json
        )

        #expect(decoded == .country)
    }

    @Test("DivisionType decodes region correctly")
    func divisionTypeRegionDecoding() throws {
        let json = Data("\"region\"".utf8)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.DivisionType.self,
            from: json
        )

        #expect(decoded == .region)
    }

    @Test("DivisionType decodes countyOrSmaller correctly")
    func divisionTypeCountyDecoding() throws {
        let json = Data("\"countyOrSmaller_4\"".utf8)
        let decoded = try JSONDecoder().decode(
            WineBottlingLocation.AdministrativeDivision.DivisionType.self,
            from: json
        )

        #expect(decoded == .countyOrSmaller(4))
    }

    @Test("DivisionType throws error on invalid format")
    func divisionTypeInvalidFormatThrows() {
        let json = Data("\"invalid_type\"".utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                WineBottlingLocation.AdministrativeDivision.DivisionType.self,
                from: json
            )
        }
    }

    @Test("DivisionType throws error on malformed countyOrSmaller")
    func divisionTypeMalformedCountyThrows() {
        let json = Data("\"countyOrSmaller_abc\"".utf8)

        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                WineBottlingLocation.AdministrativeDivision.DivisionType.self,
                from: json
            )
        }
    }
}
