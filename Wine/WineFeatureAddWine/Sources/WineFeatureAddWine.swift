import SharedCommonArchitecture
import WineDomain
import WineInteractor

@Reducer
public struct WineFeatureAddWine {
    @ObservableState
    public struct State: Equatable {
        var name: String = ""
        var isLoading: Bool = false

        @Presents var alert: AlertState<Never>?

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case submitButtonTapped
        case wineAdded(VoidResult<WineInteractorError>)

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        
        case delegate(Delegate)
        public enum Delegate: Equatable {}
    }

    public init() {}

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wineInteractor.upsert) var upsert

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .submitButtonTapped:
                    return .run { [upsert, name = state.name] send in
                        let wine = Wine.new(name: name)
                        await send(.wineAdded(await upsert(wine)))
                    }

                case .wineAdded(.failure(let error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case .wineAdded(.success):
                    state.isLoading = false
                    return .run { [dismiss] _ in await dismiss() }

                case .alert:
                    return .none

                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}
