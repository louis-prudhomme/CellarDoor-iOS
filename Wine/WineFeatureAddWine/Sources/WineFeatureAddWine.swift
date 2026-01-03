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
        var abv = 12.5 // TODO: replace by the median ABV of existing wines
        var bottlingLocation: WineBottlingLocation?
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
        case bottlingLocation(BottlingLocationSelection)
    }

    public enum Action: BindableAction {
        case submitButtonTapped
        case selectWinemakerButtonTapped
        case selectGrapeVarietiesButtonTapped
        case selectBottlingLocationButtonTapped
        case wineAdded(VoidResult<WineInteractorError>)

        case alert(PresentationAction<Never>)
        case destination(PresentationAction<Destination.Action>)
        case binding(BindingAction<State>)
    }

    public init() {}

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wineInteractor) var wineInteractor

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .submitButtonTapped:
                    // TODO: create a PartialWineBottle type to delegate validation to the interactor
                    guard let bottlingLocation = state.bottlingLocation else {
                        return .run { send in await send(.wineAdded(.failure(WineInteractorError.bottlingLocationMissing))) }
                    }

                    return .run { [
                        upsert = wineInteractor.upsert,
                        name = state.name,
                        millesime = state.millesime,
                        abv = state.abv,
                        bottlingLocation,
                        grapeVarieties = state.grapeVarieties,
                        winemaker = state.winemaker
                    ] send in
                        let wine = WineBottle(name: name, millesime: millesime, abv: abv, bottlingLocation: bottlingLocation, grapeVarieties: grapeVarieties, winemaker: winemaker)
                        let result = await upsert(wine)
                        await send(.wineAdded(result))
                    }

                case .selectWinemakerButtonTapped:
                    let winemakerInteractorDelegate = MultipleChoiceInteractorDelegate<Winemaker, WineInteractorError>(
                        fetchChoices: wineInteractor.fetchAllWinemakers,
                        createChoice: { [upsertWinemaker = wineInteractor.upsertWinemaker] name in await upsertWinemaker(Winemaker(name: name)) },
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
                        createChoice: { [upsertGrapeVariety = wineInteractor.upsertGrapeVariety] name in await upsertGrapeVariety(GrapeVariety(name: name)) },
                        getDisplayName: { $0.name }
                    )
                    state.destination = .grapeVarieties(MultipleChoiceSelection<GrapeVariety, WineInteractorError>.State(
                        title: "Grape Varieties",
                        isMultiSelect: true,
                        delegate: grapeVarietyInteractorDelegate
                    ))
                    return .none

                case .selectBottlingLocationButtonTapped:
                    state.destination = .bottlingLocation(BottlingLocationSelection.State(existing: state.bottlingLocation?.name))
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

                case let .destination(.presented(.bottlingLocation(.delegate(.locationSelected(location))))):
                    state.bottlingLocation = location
                    state.destination = nil
                    return .none

                case .destination:
                    return .none

                case .alert:
                    return .none

                case .binding:
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
