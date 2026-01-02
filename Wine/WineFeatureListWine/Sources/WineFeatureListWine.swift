import SharedCommonArchitecture
import WineDomain
import WineInteractor

@Reducer
public struct WineFeatureListWine {
    @ObservableState
    public struct State: Equatable {
        var wines = [WineBottle]()
        var isLoading = false

        @Presents var alert: AlertState<Never>?

        public init() {}
    }

    public enum Action {
        case screenAppeared
        case screenPulled
        case alertDismissed
        case wineLoaded(Result<[WineBottle], WineInteractorError>)

        case alert(PresentationAction<Never>)
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case addButtonTapped
            case popToRoot
        }
    }

    public init() {}

    @Dependency(\.wineInteractor.fetchAll) var fetchAll

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .screenAppeared, .screenPulled:
                    state.wines.removeAll()
                    state.isLoading = true
                    return .run { [fetchAll] send in
                        await send(.wineLoaded(fetchAll()))
                    }

                case .alertDismissed:
                    state.alert = nil
                    return .none

                case let .wineLoaded(.success(wines)):
                    state.isLoading = false
                    state.wines = wines
                    return .none

                case let .wineLoaded(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case .alert:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}
