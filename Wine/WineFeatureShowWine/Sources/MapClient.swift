import Dependencies
import Foundation
import SharedCommonDependencies
@preconcurrency import MapKit // FIXME: not acceptable

public struct MapClient: Sendable {
    public var open: @Sendable (_ latitude: Double, _ longitude: Double, _ name: String?) async -> SimpleResult
}

extension MapClient: DependencyKey {
    public static let liveValue = MapClient(
        open: { latitude, longitude, name in
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: location)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            let hasOpened = mapItem.openInMaps()
            return hasOpened ? .success : .failure
        }
    )

    public static let testValue = MapClient(
        open: { _, _, _ in .failure }
    )

    public static let previewValue = MapClient(
        open: { _, _, _ in .success }
    )
}

public extension DependencyValues {
    var mapClient: MapClient {
        get { self[MapClient.self] }
        set { self[MapClient.self] = newValue }
    }
}
