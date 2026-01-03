import Foundation
import SharedCommonDependencies

public struct LocationClient: Sendable {
    public var search: @Sendable (String) async -> Result<[Location], LocationClientError>

    public init(search: @escaping @Sendable (String) async -> Result<[Location], LocationClientError>) {
        self.search = search
    }
}

// MARK: - Dependency Registration

extension LocationClient: DependencyKey {
    public static let liveValue = LocationClient.live
    public static let testValue = LocationClient.mock
    public static let previewValue = LocationClient.mock
}

public extension DependencyValues {
    var locationClient: LocationClient {
        get { self[LocationClient.self] }
        set { self[LocationClient.self] = newValue }
    }
}
