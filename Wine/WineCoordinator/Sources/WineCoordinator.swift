import SharedCommonArchitecture
import WineFeatureAddWine
import WineFeatureListWine
import WineFeatureShowWine

@Reducer
public struct WineCoordinator {
    @ObservableState
    public struct State: Equatable {
        var list = WineFeatureListWine.State()
        var destination = StackState<Destination.State>()

        public init() {}
    }

    public enum Action {
        case list(WineFeatureListWine.Action)
        case destination(StackActionOf<Destination>)
    }

    // MARK: - Destinations

    @Reducer
    public enum Destination {
        case addWine(WineFeatureAddWine)
        case showWine(WineFeatureShowWine)
    }

    @Dependency(\.dismiss) var dismiss

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.list, action: \.list) {
            WineFeatureListWine()
        }

        Reduce { state, action in
            switch action {
                // MARK: - List Actions

                case .list(.delegate(.addButtonTapped)):
                    state.destination.append(.addWine(WineFeatureAddWine.State()))
                    return .none

                // MARK: - Leaf Actions

                case .list(.delegate(.popToRoot)):
                    return .run { [dismiss] _ in await dismiss() }

                case let .list(.delegate(.wineTapped(wine))):
                    state.destination.append(.showWine(WineFeatureShowWine.State(bottle: wine)))
                    return .none

                default:
                    return .none
            }
        }
        .forEach(\.destination, action: \.destination)
    }
}

/// Necessary to make StackState work
extension WineCoordinator.Destination.State: Equatable {}
