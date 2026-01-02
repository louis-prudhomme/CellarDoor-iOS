import SharedCommonArchitecture
import SharedCommonInteractor
import SwiftUI

@Reducer
public struct AddChoice<Choice: Choosable, IError: InteractorError> {
    @ObservableState
    public struct State: Equatable {
        public let delegate: MultipleChoiceInteractorDelegate<Choice, IError>
        public let title: String

        @Presents var alert: AlertState<Never>?

        public var choiceName = ""
        public var isLoading = false

        public init(title: String, delegate: MultipleChoiceInteractorDelegate<Choice, IError>) {
            self.title = title
            self.delegate = delegate
        }

        public static func == (lhs: AddChoice<Choice, IError>.State, rhs: AddChoice<Choice, IError>.State) -> Bool {
            lhs.title == rhs.title
                && lhs.choiceName == rhs.choiceName
                && lhs.isLoading == rhs.isLoading
        }
    }

    public enum Action: BindableAction {
        case submitChoiceButtonTapped
        case choiceAdditionFinished(VoidResult<IError>)

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)

        public enum Delegate: Sendable {
            case choiceAdded
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .submitChoiceButtonTapped:
                    state.isLoading = true

                    return .run { [delegate = state.delegate, choiceName = state.choiceName] send in
                        let result: VoidResult<IError> = await delegate.createChoice(choiceName)
                        await send(.choiceAdditionFinished(result))
                    }

                case let .choiceAdditionFinished(.failure(error)):
                    state.isLoading = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case .choiceAdditionFinished(.success):
                    state.isLoading = false
                    return .run { send in await send(.delegate(.choiceAdded)) }

                case .alert:
                    return .none

                // TODO: when text changes, check if name available
                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}
