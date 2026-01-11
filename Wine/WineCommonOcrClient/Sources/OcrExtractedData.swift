import Foundation

public struct OcrExtractedData: Equatable, Sendable {
    public var millesime: Int?
    public var abv: Double?
    public var extractedStrings: [String]
    public var pictureData: Data?

    public init(
        millesime: Int? = nil,
        abv: Double? = nil,
        extractedStrings: [String] = [],
        pictureData: Data? = nil
    ) {
        self.millesime = millesime
        self.abv = abv
        self.extractedStrings = extractedStrings
        self.pictureData = pictureData
    }

    public var suggestedName: String? {
        extractedStrings
            .filter { string in
                !string.allSatisfy { $0.isNumber || $0 == "." || $0 == "%" }
            }
            .first { $0.count > 2 }
    }
}
