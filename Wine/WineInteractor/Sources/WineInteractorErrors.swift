import Foundation
import SharedCommonInteractor

public enum WineInteractorError: InteractorError {
    case nameEmpty
    case notFound
    case unknown

    public init(_ error: any Error) {
        self = .unknown
    }

    public var errorDescription: String? {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
            case .nameEmpty: "Name cannot be empty."
            case .notFound: "Wine not found."
            case .unknown: "An unknown error occurred."
        }
    }
}