import SharedCommonArchitecture
import SharedCommonDependencies
import SwiftUI

@Reducer
public struct MultipleChoiceSelection<Choice: Choosable, IError: ClientError> {
    @ObservableState
    public struct State: Equatable {
        public let delegate: MultipleChoiceInteractorDelegate<Choice, IError>
        public let isMultiSelect: Bool
        public let title: String

        @Presents var alert: AlertState<Never>?
        @Presents var destination: Destination.State?

        public var searchText = ""
        public var choices = [Choice]()
        public var selectedChoices = [Choice]()
        public var isLoading = false
        public var isCreatingChoice = false

        public init(title: String, isMultiSelect: Bool, delegate: MultipleChoiceInteractorDelegate<Choice, IError>) {
            self.title = title
            self.isMultiSelect = isMultiSelect
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
        case choicesLoaded(Result<[Choice], IError>)
        case submitSelectedChoicesButtonTapped

        case addChoiceButtonTapped
        case createChoiceButtonTapped
        case choiceCreationFinished(Result<Choice, IError>)

        case destination(PresentationAction<Destination.Action>)
        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case choicesSelected([Choice])
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .binding(\.searchText), .onAppear:
                    state.isLoading = true
                    return .run { [delegate = state.delegate, searchText = state.searchText] send in
                        let result = await delegate.fetchChoices(searchText)
                        await send(.choicesLoaded(result))
                    }

                case let .choicesLoaded(.success(choices)):
                    state.isLoading = false
                    state.choices = choices
                    return .none

                case let .choicesLoaded(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case let .choiceSelected(choice):
                    if state.isMultiSelect {
                        if state.selectedChoices.contains(choice) {
                            state.selectedChoices.removeAll { $0 == choice }
                        } else {
                            state.selectedChoices.append(choice)
                        }
                        return .none
                    } else {
                        return .send(.delegate(.choicesSelected([choice])))
                    }

                case .submitSelectedChoicesButtonTapped:
                    return .send(.delegate(.choicesSelected(state.selectedChoices)))

                case .addChoiceButtonTapped:
                    state.destination = .addChoice(AddChoice<Choice, IError>.State(
                        title: state.title,
                        delegate: state.delegate
                    ))
                    return .none

                case .createChoiceButtonTapped:
                    state.isCreatingChoice = true
                    return .run { [delegate = state.delegate, searchText = state.searchText] send in
                        let result = await delegate.createChoice(searchText)
                        await send(.choiceCreationFinished(result))
                    }

                case .choiceCreationFinished(.success(let choice)):
                    state.isCreatingChoice = false
                    state.searchText = ""
                    return .run { [choice] send in
                        await send(.onAppear)
                        await send(.choiceSelected(choice))
                    }

                case .choiceCreationFinished(.failure(let error)):
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case let .destination(.presented(.addChoice(.delegate(.choiceAdded(choice))))):
                    state.destination = nil
                    return .run { send in
                        await send(.onAppear)
                        await send(.choiceSelected(choice))
                    }

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

public struct MultipleChoiceInteractorDelegate<Choice: Choosable, IError: ClientError>: Sendable {
    let fetchChoices: @Sendable (String) async -> Result<[Choice], IError>
    let createChoice: @Sendable (String) async -> Result<Choice, IError>
    let getDisplayName: @Sendable (Choice) -> String
}

// MARK: - Conformances

extension MultipleChoiceSelection.Destination.State: Equatable {}
