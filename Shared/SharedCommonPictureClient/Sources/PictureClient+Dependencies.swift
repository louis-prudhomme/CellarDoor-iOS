import Foundation
import SharedCommonDependencies

public enum PictureSource: Sendable {
    case camera
    case photoLibrary
}

public struct PictureClient: Sendable {
    public var selectPicture: @Sendable (PictureSource) async -> Result<Data, PictureClientError>
    public var compressPicture: @Sendable (Data, Double) async -> Result<Data, PictureClientError>

    public init(
        selectPicture: @escaping @Sendable (PictureSource) async -> Result<Data, PictureClientError>,
        compressPicture: @escaping @Sendable (Data, Double) async -> Result<Data, PictureClientError>
    ) {
        self.selectPicture = selectPicture
        self.compressPicture = compressPicture
    }
}

// MARK: - Dependency Registration

extension PictureClient: DependencyKey {
    public static let liveValue = PictureClient.live
    public static let testValue = PictureClient.mock
    public static let previewValue = PictureClient.mock
}

public extension DependencyValues {
    var pictureClient: PictureClient {
        get { self[PictureClient.self] }
        set { self[PictureClient.self] = newValue }
    }
}
