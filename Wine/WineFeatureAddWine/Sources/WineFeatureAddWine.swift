import Foundation
import SharedCommonArchitecture
import SharedCommonDependencies
import WineDomain
import WineInteractor

@Reducer
public struct WineFeatureAddWine {
    @ObservableState
    public struct State: Equatable {
        var name = ""
        var millesime: Int
        var winemaker: Winemaker?
        var grapeVarieties = [GrapeVariety]()
        var abv = 12.5
        var isLoading = false

        @Presents var alert: AlertState<Never>?
        @Presents var destination: Destination.State?

        public init() {
            @Dependency(\.date) var date
            @Dependency(\.calendar) var calendar

            millesime = calendar.component(.year, from: date())
        }
    }

    @Reducer
    public enum Destination {
        case winemaker(MultipleChoiceSelection<Winemaker, WineInteractorError>)
        case grapeVarieties(MultipleChoiceSelection<GrapeVariety, WineInteractorError>)
    }

    public enum Action: BindableAction {
        case submitButtonTapped
        case selectWinemakerButtonTapped
        case selectGrapeVarietiesButtonTapped
        case wineAdded(VoidResult<WineInteractorError>)

        case alert(PresentationAction<Never>)
        case destination(PresentationAction<Destination.Action>)
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
                    return .run { [upsert = wineInteractor.upsert, name = state.name, millesime = state.millesime, abv = state.abv, grapeVarieties = state.grapeVarieties, winemaker = state.winemaker] send in
                        let wine = WineBottle.new(name: name, millesime: millesime, abv: abv, grapeVarieties: grapeVarieties, winemaker: winemaker)
                        await send(.wineAdded(upsert(wine)))
                    }

                case .selectWinemakerButtonTapped:
                    let winemakerInteractorDelegate = MultipleChoiceInteractorDelegate<Winemaker, WineInteractorError>(
                        fetchChoices: wineInteractor.fetchAllWinemakers,
                        createChoice: { [upsertWinemaker = wineInteractor.upsertWinemaker] name in await upsertWinemaker(Winemaker.new(name: name)) },
                        getDisplayName: { $0.name }
                    )
                    state.destination = .winemaker(MultipleChoiceSelection<Winemaker, WineInteractorError>.State(
                        title: "Winemaker",
                        isMultiSelect: false,
                        delegate: winemakerInteractorDelegate
                    ))
                    return .none

                case .selectGrapeVarietiesButtonTapped:
                    let grapeVarietyInteractorDelegate = MultipleChoiceInteractorDelegate<GrapeVariety, WineInteractorError>(
                        fetchChoices: wineInteractor.fetchAllGrapeVarieties,
                        createChoice: { [upsertGrapeVariety = wineInteractor.upsertGrapeVariety] name in await upsertGrapeVariety(GrapeVariety.new(name: name)) },
                        getDisplayName: { $0.name }
                    )
                    state.destination = .grapeVarieties(MultipleChoiceSelection<GrapeVariety, WineInteractorError>.State(
                        title: "Grape Varieties",
                        isMultiSelect: true,
                        delegate: grapeVarietyInteractorDelegate
                    ))
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

                case let .destination(.presented(.winemaker(.delegate(.choicesSelected(winemakers))))):
                    state.winemaker = winemakers.first
                    state.destination = nil
                    return .none

                case let .destination(.presented(.grapeVarieties(.delegate(.choicesSelected(grapeVarieties))))):
                    state.grapeVarieties = grapeVarieties
                    state.destination = nil
                    return .none

                case .destination:
                    return .none

                case .alert:
                    return .none

                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

// MARK: Conformances

extension Winemaker: Choosable {}
extension GrapeVariety: Choosable {}
extension WineFeatureAddWine.Destination.State: Equatable {}
