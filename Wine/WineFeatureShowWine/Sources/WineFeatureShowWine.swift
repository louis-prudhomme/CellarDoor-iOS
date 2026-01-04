import SharedCommonArchitecture
import SharedCommonDependencies
import WineDomain

@Reducer
public struct WineFeatureShowWine {
    @ObservableState
    public struct State: Equatable {
        let bottle: WineBottle

        public init(bottle: WineBottle) {
            self.bottle = bottle
        }
    }

    public enum Action {
        case showMapButtonTapped
        case mapFinishedOpening(SimpleResult)

        case delegate(Delegate)

        public enum Delegate: Equatable {}
    }

    public init() {}

    @Dependency(\.mapClient) var mapClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .showMapButtonTapped:
                    let coordinates = state.bottle.bottlingLocation.coordinates
                    let name = state.bottle.bottlingLocation.name

                    return .run { [mapClient] send in
                        let result = await mapClient.open(
                            coordinates.latitude,
                            coordinates.longitude,
                            name
                        )
                        await send(.mapFinishedOpening(result))
                    }

                case .mapFinishedOpening:
                    // TODO: handle this more gracefully
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}
