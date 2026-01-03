import Foundation
import SharedCommonDependencies

public enum WineInteractorError: ClientError {
    case nameEmpty
    case millesimeInvalid
    case grapeVarietyEmpty
    case notFound
    case invalidAbv
    case badData
    case bottlingLocationMissing
    case unknown

    public init(_: any Error) {
        self = .unknown
    }

    public var errorDescription: String? {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
            case .nameEmpty: "Name cannot be empty."
            case .millesimeInvalid: "Vintage year cannot be in the future."
            case .grapeVarietyEmpty: "At least one grape variety must be selected."
            case .notFound: "Wine not found."
            case .invalidAbv: "AbV must be between 0 and 100."
            case .badData: "Failed decoding data from the database."
            case .bottlingLocationMissing: "Bottling location is missing."
            case .unknown: "An unknown error occurred."
        }
    }
}
