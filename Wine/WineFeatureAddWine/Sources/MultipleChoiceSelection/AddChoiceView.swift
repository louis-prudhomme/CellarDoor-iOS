import SharedCommonArchitecture
import SharedCommonDesignSystem
import SharedCommonInteractor
import SwiftUI

struct AddChoiceView<Choice: Choosable, IError: InteractorError>: View {
    @Bindable var store: StoreOf<AddChoice<Choice, IError>>

    init(store: StoreOf<AddChoice<Choice, IError>>) {
        self.store = store
    }

    var body: some View {
        VStack {
            TextField("Enter name", text: $store.choiceName)
                .textFieldStyle(.roundedBorder)
                .padding()

            Spacer()

            CellarButton("Create \(store.choiceName)", systemImage: "plus", isLoading: store.isLoading) {
                store.send(.submitChoiceButtonTapped)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .alert($store.scope(state: \.alert, action: \.alert))
        .navigationTitle("Create \(store.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
private struct Example: Choosable {
    let id = "ID"
    let name = "Xavier Frissant"
}

private enum ExampleEmptyError: InteractorError {}

#Preview {
    let delegate = MultipleChoiceInteractorDelegate<Example, ExampleEmptyError>(
        fetchChoices: { _ in .success([]) },
        createChoice: { _ in .success },
        getDisplayName: { $0.name }
    )
    let state = AddChoice.State(
        title: "Winemaker",
        delegate: delegate
    )

    Color.pink.ignoresSafeArea().sheet(isPresented: .constant(true)) {
        AddChoiceView<Example, ExampleEmptyError>(
            store: Store(initialState: state) {
                AddChoice<Example, ExampleEmptyError>()
            }
        )
    }
}
#endif
