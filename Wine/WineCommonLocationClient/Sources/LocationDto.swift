import Foundation

// MARK: - DTO

public struct GeoNameDTO: Codable {
    public let geonameId: Int
    public let name: String
    public let lat: String
    public let lng: String
    public let countryCode: String?
    public let countryName: String?
    public let adminCode1: String? // Centre Val de Loire
    public let adminName1: String? // 24
    public let adminCode2: String? // Indre-et-Loire
    public let adminName2: String? // 37
    public let adminCode3: String? // Arrondissement de Loches
    public let adminName3: String? // 373
    public let adminCode4: String? // Mosnes
    public let adminName4: String? // 37530
    public let adminCode5: String? // Districts
    public let adminName5: String? // Marseille 8
    public let population: Int?
    public let elevation: Int?
    public let timezone: Timezone?
    public let fcl: String?
    public let fcode: String?
    public let fclName: String?
    public let fcodeName: String?

    public init(
        geonameId: Int,
        name: String,
        lat: String,
        lng: String,
        countryCode: String? = nil,
        countryName: String? = nil,
        adminCode1: String? = nil,
        adminName1: String? = nil,
        adminCode2: String? = nil,
        adminName2: String? = nil,
        adminCode3: String? = nil,
        adminName3: String? = nil,
        adminCode4: String? = nil,
        adminName4: String? = nil,
        adminCode5: String? = nil,
        adminName5: String? = nil,
        population: Int? = nil,
        elevation: Int? = nil,
        timezone: Timezone? = nil,
        fcl: String? = nil,
        fcode: String? = nil,
        fclName: String? = nil,
        fcodeName: String? = nil
    ) {
        self.geonameId = geonameId
        self.name = name
        self.lat = lat
        self.lng = lng
        self.countryCode = countryCode
        self.countryName = countryName
        self.adminCode1 = adminCode1
        self.adminName1 = adminName1
        self.adminCode2 = adminCode2
        self.adminName2 = adminName2
        self.adminCode3 = adminCode3
        self.adminName3 = adminName3
        self.adminCode4 = adminCode4
        self.adminName4 = adminName4
        self.adminCode5 = adminCode5
        self.adminName5 = adminName5
        self.population = population
        self.elevation = elevation
        self.timezone = timezone
        self.fcl = fcl
        self.fcode = fcode
        self.fclName = fclName
        self.fcodeName = fcodeName
    }
}

public struct Timezone: Codable {
    public let timeZoneId: String
    public let dstOffset: Double
    public let gmtOffset: Double

    public init(timeZoneId: String, dstOffset: Double, gmtOffset: Double) {
        self.timeZoneId = timeZoneId
        self.dstOffset = dstOffset
        self.gmtOffset = gmtOffset
    }
}

// MARK: - Search Result

struct GeoNamesSearchDTO: Codable {
    let geonames: [GeoNameDTO]?
    let status: GeoNamesStatusDto?
    let totalResultsCount: Int?
}

struct GeoNamesStatusDto: Codable {
    let message: String
    let value: Int
}

// MARK: - Query Parameters

public struct GeoNamesQueryParameters: Codable {
    // one of query / placename is required, but placename is better suited for our use case
    let placename: String
    let maxRows: Int
    let countryBias: String
    let languageCode: String // 2-letter ISO code
    let responseStyle: ResponseStyle
    let featureClass: FeatureClass // FIXME: we'd like several, but URLQueryItemEncoder is busted
    // let featureCode: String = "PPL&featureCode=PPLA3&featureCode=PPLA4" // TODO: should be an enum - PPLAx are for admin divisions (ex: Saumur is PPLA3) but URLQueryItemEncoder is busted

    enum CodingKeys: String, CodingKey {
        // case query = "q"
        case placename = "name"
        case maxRows
        case countryBias
        case languageCode = "lang"
        case responseStyle = "style"
        case featureClass
        // case featureCode
    }
}

public extension GeoNamesQueryParameters {
    enum ResponseStyle: String, Codable {
        case short = "SHORT"
        case medium = "MEDIUM"
        case long = "LONG"
        case full = "FULL" // the only one with all administrative divisions
    }
}

public extension GeoNamesQueryParameters {
    enum FeatureClass: String, Codable {
        case A
        case H
        case L
        case P
        case R
        case S
        case T
        case U
        case V
    }
}

extension GeoNamesQueryParameters {
    static func defaultWith(name: String, maxRows: Int = 20, languageCode: String = "en") -> GeoNamesQueryParameters {
        return GeoNamesQueryParameters(
            placename: name,
            maxRows: maxRows,
            countryBias: "FR",
            languageCode: languageCode,
            responseStyle: .full,
            featureClass: .P
        )
    }
}
