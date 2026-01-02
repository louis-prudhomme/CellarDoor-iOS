import SharedCommonArchitecture
import WineCoordinator

@Reducer
public struct AppCoordinator {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?

        public init() {}
    }

    public enum Action {
        case destination(PresentationAction<Destination.Action>)
        case navigateToWines
    }

    public init() {}

    @Reducer
    public enum Destination {
        case wines(WineCoordinator)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .navigateToWines:
                    state.destination = .wines(WineCoordinator.State())
                    return .none

                case .destination:
                    return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

/// Necessary for protocol conformance
extension AppCoordinator.Destination.State: Equatable {}
