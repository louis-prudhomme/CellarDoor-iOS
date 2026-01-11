import Foundation

public enum OcrClientError: Error, Equatable, LocalizedError, Sendable {
    case noTextFound
    case processingFailed(String)

    public var errorDescription: String? {
        switch self {
            case .noTextFound:
                return "No text was found in the image. Please try again with a clearer picture."
            case let .processingFailed(message):
                return "Failed to process image: \(message)"
        }
    }
}
