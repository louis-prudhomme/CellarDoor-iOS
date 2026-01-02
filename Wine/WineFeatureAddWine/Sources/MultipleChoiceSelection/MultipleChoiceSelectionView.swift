import SharedCommonArchitecture
import SharedCommonInteractor
import SwiftUI

struct MultipleChoiceSelectionView<Choice: Choosable, IError: InteractorError>: View {
    @Bindable var store: StoreOf<MultipleChoiceSelection<Choice, IError>>

    init(store: StoreOf<MultipleChoiceSelection<Choice, IError>>) {
        self.store = store
    }

    var body: some View {
        NavigationStack {
            VStack {
                if store.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(store.choices) { choice in
                            Button {
                                store.send(.choiceSelected(choice))
                            } label: {
                                Text(getDisplayName(for: choice))
                            }
                        }
                    }
                    .searchable(text: $store.searchText)
                }
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.addChoice,
                    action: \.destination.addChoice
                )
            ) { store in
                AddChoiceView(store: store)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add a \(store.title)", systemImage: "plus") {
                        store.send(.addChoiceButtonTapped)
                    }
                }
            }
            .navigationTitle("Select a \(store.title)")
            .navigationBarTitleDisplayMode(.inline)
            .task { store.send(.onAppear) }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }

    func getDisplayName(for choice: Choice) -> String {
        store.delegate.getDisplayName(choice)
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
        fetchChoices: { _ in .success([
            Example()
        ]) },
        createChoice: { _ in .success },
        getDisplayName: { $0.name }
    )
    let state = MultipleChoiceSelection.State(
        title: "Winemaker",
        delegate: delegate
    )

    Color.pink.ignoresSafeArea().sheet(isPresented: .constant(true)) {
        MultipleChoiceSelectionView<Example, ExampleEmptyError>(
            store: Store(initialState: state) {
                MultipleChoiceSelection()
            }
        )
    }
}
#endif
