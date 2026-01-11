import SharedCommonArchitecture
import WineFeatureAddWine
import WineFeatureListWine
import WineFeatureOcrWine
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
        case delegate(Delegate)
    }

    public enum Delegate {
        case popToRoot
    }

    // MARK: - Destinations

    @Reducer
    public enum Destination {
        case addWine(WineFeatureAddWine)
        case showWine(WineFeatureShowWine)
        case ocrWine(WineFeatureOcrWine)
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

                case .list(.delegate(.ocrButtonTapped)):
                    state.destination.append(.ocrWine(WineFeatureOcrWine.State()))
                    return .none

                // MARK: - Leaf Actions

                case .list(.delegate(.popToRoot)):
                    // Send delegate action up to AppCoordinator
                    return .send(.delegate(.popToRoot))

                case let .list(.delegate(.wineTapped(wine))):
                    state.destination.append(.showWine(WineFeatureShowWine.State(bottle: wine)))
                    return .none

                case let .destination(.element(id: _, action: .ocrWine(.destination(.presented(.extracted(.delegate(.extractedDataConfirmed(extractedData)))))))):
                    state.destination.append(.addWine(WineFeatureAddWine.State(
                        name: extractedData.suggestedName ?? "",
                        millesime: extractedData.millesime,
                        abv: extractedData.abv,
                        picture: extractedData.pictureData,
                        extractedStrings: extractedData.extractedStrings
                    )))
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
