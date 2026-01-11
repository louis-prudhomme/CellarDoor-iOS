import Foundation
import UIKit
import Vision

public extension OcrClient {
    static let live = OcrClient(
        performOcr: { imageData in
            guard let cgImage = createCGImage(from: imageData) else {
                return .failure(.processingFailed("Could not create image from data"))
            }

            return await withCheckedContinuation { continuation in
                let request = VNRecognizeTextRequest { request, error in
                    if let error {
                        continuation.resume(returning: .failure(.processingFailed(error.localizedDescription)))
                        return
                    }

                    guard let observations = request.results as? [VNRecognizedTextObservation], !observations.isEmpty else {
                        continuation.resume(returning: .failure(.noTextFound))
                        return
                    }

                    let extractedData = processOcrObservations(observations, pictureData: imageData)
                    continuation.resume(returning: .success(extractedData))
                }

                request.recognitionLevel = .accurate
                request.recognitionLanguages = ["fr-FR", "en-US"]
                request.usesLanguageCorrection = true

                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

                do {
                    try handler.perform([request])
                } catch {
                    continuation.resume(returning: .failure(.processingFailed(error.localizedDescription)))
                }
            }
        }
    )
}

// MARK: - Private Helpers

private func createCGImage(from data: Data) -> CGImage? {
    UIImage(data: data)?.cgImage
}

private func processOcrObservations(_ observations: [VNRecognizedTextObservation], pictureData: Data) -> OcrExtractedData {
    var allStrings = [String]()
    var millesime: Int?
    var abv: Double?

    let yearPattern = /\b(19|20)\d{2}\b/
    let abvPattern = /\b(\d{1,2}([.,]\d{1,2})?)\s*(%|vol|°)/

    for observation in observations {
        guard let candidate = observation.topCandidates(1).first else { continue }

        let text = candidate.string.trimmingCharacters(in: .whitespacesAndNewlines)

        if !text.isEmpty {
            allStrings.append(text)

            // Try to extract year (millesime)
            if millesime == nil, let match = text.firstMatch(of: yearPattern) {
                millesime = Int(match.0)
            }

            // Try to extract AbV
            if abv == nil, let match = text.firstMatch(of: abvPattern) {
                let abvString = String(match.1).replacingOccurrences(of: ",", with: ".")
                abv = Double(abvString)
            }
        }
    }

    return OcrExtractedData(
        millesime: millesime,
        abv: abv,
        extractedStrings: allStrings,
        pictureData: pictureData
    )
}
