import Foundation
import SharedCommonDependencies

public struct OcrClient: Sendable {
    public var performOcr: @Sendable (Data) async -> Result<OcrExtractedData, OcrClientError>

    public init(
        performOcr: @escaping @Sendable (Data) async -> Result<OcrExtractedData, OcrClientError>
    ) {
        self.performOcr = performOcr
    }
}

// MARK: - Dependency Registration

extension OcrClient: DependencyKey {
    public static let liveValue = OcrClient.live
    public static let testValue = OcrClient.mock
    public static let previewValue = OcrClient.mock
}

public extension DependencyValues {
    var ocrClient: OcrClient {
        get { self[OcrClient.self] }
        set { self[OcrClient.self] = newValue }
    }
}
