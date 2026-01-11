import Foundation

public extension OcrClient {
    static let mock = OcrClient(
        performOcr: { imageData in
            .success(
                OcrExtractedData(
                    millesime: 2_020,
                    abv: 13.5,
                    extractedStrings: ["Château Margaux", "2020", "13.5% vol"],
                    pictureData: imageData
                )
            )
        }
    )
}
