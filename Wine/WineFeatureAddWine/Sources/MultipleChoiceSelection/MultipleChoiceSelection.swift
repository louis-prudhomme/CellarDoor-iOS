import SharedCommonArchitecture
import SharedCommonInteractor
import SwiftUI

@Reducer
public struct MultipleChoiceSelection<Choice: Choosable, IError: InteractorError> {
    @ObservableState
    public struct State: Equatable {
        public let delegate: MultipleChoiceInteractorDelegate<Choice, IError>
        public let title: String

        @Presents var alert: AlertState<Never>?
        @Presents var destination: Destination.State?

        public var searchText = ""
        public var choices: [Choice] = []
        public var isLoading = false

        public init(title: String, delegate: MultipleChoiceInteractorDelegate<Choice, IError>) {
            self.title = title
            self.delegate = delegate
        }

        public static func == (lhs: MultipleChoiceSelection<Choice, IError>.State, rhs: MultipleChoiceSelection<Choice, IError>.State) -> Bool {
            lhs.title == rhs.title
                && lhs.searchText == rhs.searchText
                && lhs.choices == rhs.choices
                && lhs.isLoading == rhs.isLoading
        }
    }

    @Reducer
    public enum Destination {
        case addChoice(AddChoice<Choice, IError>)
    }

    public enum Action: BindableAction {
        case onAppear
        case choiceSelected(Choice)
        case searchTextChanged(String)
        case choicesLoaded(Result<[Choice], IError>)

        case addChoiceButtonTapped

        case destination(PresentationAction<Destination.Action>)
        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case choiceSelected(Choice)
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .onAppear:
                    state.isLoading = true
                    state.choices = []
                    return .run { [delegate = state.delegate, searchText = state.searchText] send in
                        await send(.choicesLoaded(delegate.fetchChoices(searchText)))
                    }

                case let .choicesLoaded(.success(choices)):
                    state.choices = choices
                    state.isLoading = false
                    return .none

                case let .choicesLoaded(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case let .searchTextChanged(text):
                    state.searchText = text
                    return .none

                case let .choiceSelected(choice):
                    return .send(.delegate(.choiceSelected(choice)))

                case .addChoiceButtonTapped:
                    state.destination = .addChoice(AddChoice<Choice, IError>.State(
                        title: state.title,
                        delegate: state.delegate
                    ))
                    return .none

                case .destination(.presented(.addChoice(.delegate(.choiceAdded)))):
                    state.destination = nil
                    return .run { send in await send(.onAppear) }

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

// MARK: - Companion protocol

public protocol Choosable: Equatable, Identifiable, Sendable {}

public struct MultipleChoiceInteractorDelegate<Choice: Choosable, IError: InteractorError>: Sendable {
    let fetchChoices: @Sendable (String) async -> Result<[Choice], IError>
    let createChoice: @Sendable (String) async -> VoidResult<IError>
    let getDisplayName: @Sendable (Choice) -> String
}

// MARK: - Conformances

extension MultipleChoiceSelection.Destination.State: Equatable {}
