import Foundation
import SharedCommonDependencies

public enum PictureClientError: ClientError {
    case cancelled
    case permissionDenied
    case sourceNotAvailable
    case compressionFailed
    case invalidData
    case unknown(message: String)

    public init(_ error: any Error) {
        self = .unknown(message: error.localizedDescription)
    }

    public var errorDescription: String? {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
            case .cancelled: "Picture selection was cancelled."
            case .permissionDenied: "Camera or photo library access denied."
            case .sourceNotAvailable: "The requested source (camera or photo library) is not available."
            case .compressionFailed: "Failed to compress the image."
            case .invalidData: "The selected image data is invalid."
            case let .unknown(message): "An unknown error occurred: \(message)"
        }
    }
}
