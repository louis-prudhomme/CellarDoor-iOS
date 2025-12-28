import SharedCommonArchitecture
import WineFeatureListWine
import WineFeatureAddWine

@Reducer
public struct WineCoordinator {
    @ObservableState
    public struct State: Equatable {
        var list = WineFeatureListWine.State()
        var path = StackState<Path.State>()

        public init() {}
    }
    
    public enum Action {
        case list(WineFeatureListWine.Action)
        case path(StackActionOf<Path>)
    }
    
    // MARK: - Destinations
    @Reducer
    public enum Path {
        case addWine(WineFeatureAddWine)
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
                    state.path.append(.addWine(WineFeatureAddWine.State()))
                    return .none
                
                // MARK: - Leaf Actions
                case .list(.delegate(.popToRoot)):
                    return .run { [dismiss] _ in await dismiss() }
                
                default:
                    return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

// Necessary to make StackState work
extension WineCoordinator.Path.State: Equatable {}