@preconcurrency import Dispatch // FIXME: not acceptable
import SharedCommonArchitecture
import SharedCommonDependencies
import SwiftUI
import WineCommonLocationClient
import WineInteractor

@Reducer
public struct BottlingLocationSelection {
    @ObservableState
    public struct State: Equatable {
        public var existing: String?
        public var searchText = ""
        public var suggestedLocations = [Location]()
        public var isLoading = false

        @Presents var alert: AlertState<Never>?

        public init(existing: String?) {
            self.existing = existing
            if let existing, !existing.isEmpty {
                searchText = existing
            }
        }
    }

    public enum Action: BindableAction, Sendable {
        case locationsLoaded(Result<[Location], LocationClientError>)
        case locationSelected(Location)

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)

        public enum Delegate: Equatable, Sendable {
            case locationSelected(WineBottlingLocation)
        }
    }

    @Dependency(\.locationClient.search) var search
    @Dependency(\.mainQueue) var scheduler

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce {
            state, action in
            switch action {
                case .binding(\.searchText):
                    if state.searchText.isEmpty, state.isLoading == false {
                        return .none
                    }

                    state.isLoading = true

                    return .run { [searchText = state.searchText, search] send in
                        let result = await search(searchText)
                        await send(.locationsLoaded(result))
                    }
                    .throttle(id: Cancellables.search, for: .milliseconds(300), scheduler: scheduler, latest: false)

                case let .locationsLoaded(.success(locations)):
                    state.isLoading = false
                    state.suggestedLocations = locations
                    return .none

                case let .locationsLoaded(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case let .locationSelected(location):
                    return .run { send in
                        await send(.delegate(.locationSelected(WineBottlingLocation(from: location))))
                    }

                case .alert, .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }

    private enum Cancellables {
        case search
    }
}

// MARK: - Adapters Client => Domain

extension WineBottlingLocation {
    init(from location: Location) {
        self.init(
            name: location.name,
            coordinates: GeographicalCoordinates(from: location.coordinates),
            administrativeDivisions: location.administrativeDivisions.map { AdministrativeDivision(from: $0) },
            providerId: location.id
        )
    }
}

extension WineBottlingLocation.GeographicalCoordinates {
    init(from coordinates: Location.GeographicalCoordinates) {
        self.init(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

extension WineBottlingLocation.AdministrativeDivision {
    init(from division: Location.AdministrativeDivision) {
        self.init(
            type: DivisionType(from: division.type), name: division.name, code: division.code
        )
    }
}

extension WineBottlingLocation.AdministrativeDivision.DivisionType {
    init(from type: Location.AdministrativeDivision.`Type`) {
        self = switch type {
            case .country: .country
            case .region: .region
            case .countyOrSmaller: .countyOrSmaller
        }
    }
}
