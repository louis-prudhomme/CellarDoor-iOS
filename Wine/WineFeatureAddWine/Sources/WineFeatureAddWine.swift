import Foundation
import SharedCommonArchitecture
import WineDomain
import WineInteractor

@Reducer
public struct WineFeatureAddWine {
    @ObservableState
    public struct State: Equatable {
        var name = ""
        var millesime: Int
        var winemaker: Winemaker?
        var isLoading = false

        @Presents var alert: AlertState<Never>?
        @Presents var winemakerSheet: MultipleChoiceSelection<Winemaker, WineInteractorError>.State?

        public init() {
            @Dependency(\.date) var date

            millesime = Calendar.current.component(.year, from: date())
        }
    }

    public enum Action: BindableAction {
        case submitButtonTapped
        case selectWinemakerButtonTapped
        case wineAdded(VoidResult<WineInteractorError>)

        case alert(PresentationAction<Never>)
        case winemakerSheet(PresentationAction<MultipleChoiceSelection<Winemaker, WineInteractorError>.Action>)
        case binding(BindingAction<State>)

        case delegate(Delegate)
        public enum Delegate: Equatable {}
    }

    public init() {}

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wineInteractor) var wineInteractor

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .submitButtonTapped:
                    return .run { [upsert = wineInteractor.upsert, name = state.name, millesime = state.millesime, winemaker = state.winemaker] send in
                        let wine = WineBottle.new(name: name, millesime: millesime, winemaker: winemaker)
                        await send(.wineAdded(upsert(wine)))
                    }

                case .selectWinemakerButtonTapped:
                    let winemakerInteractorDelegate = MultipleChoiceInteractorDelegate<Winemaker, WineInteractorError>(
                        fetchChoices: wineInteractor.fetchAllWinemakers,
                        createChoice: { [upsertWinemaker = wineInteractor.upsertWinemaker] name in await upsertWinemaker(Winemaker.new(name: name)) },
                        getDisplayName: { $0.name }
                    )
                    state.winemakerSheet = MultipleChoiceSelection<Winemaker, WineInteractorError>.State(
                        title: "Winemaker",
                        delegate: winemakerInteractorDelegate
                    )
                    return .none

                case let .wineAdded(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case .wineAdded(.success):
                    state.isLoading = false
                    return .run { [dismiss] _ in await dismiss() }

                case let .winemakerSheet(.presented(.delegate(.choiceSelected(winemaker)))):
                    state.winemaker = winemaker
                    state.winemakerSheet = nil
                    return .none

                case .winemakerSheet:
                    return .none

                case .alert:
                    return .none

                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
        .ifLet(\.$winemakerSheet, action: \.winemakerSheet) {
            MultipleChoiceSelection<Winemaker, WineInteractorError>()
        }
    }
}

// MARK: Conformances

extension Winemaker: Choosable {}
