import SharedCommonArchitecture
import SharedCommonDependencies
import SharedCommonDesignSystem
import SwiftUI

struct MultipleChoiceSelectionView<Choice: Choosable, IError: ClientError>: View {
    @Bindable var store: StoreOf<MultipleChoiceSelection<Choice, IError>>

    init(store: StoreOf<MultipleChoiceSelection<Choice, IError>>) {
        self.store = store
    }

    var body: some View {
        VStack {
            List {
                ForEach(store.choices) { choice in
                    let isSelected = store.selectedChoices.contains(choice)
                    ChoiceView(choice: choice, isSelected: isSelected, store: store)
                }
            }

            if store.isMultiSelect {
                submitButton
            }
        }
        .loadable(isLoading: store.isLoading)
        .emptyable(store.choices, searchText: store.searchText, isLoading: store.isLoading)
        .searchable(text: $store.searchText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add a \(store.title)", systemImage: "plus") {
                    store.send(.addChoiceButtonTapped)
                }
            }
        }
        .navigationTitle(store.isMultiSelect ? "Select one or more" : "Pick a \(store.title)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $store.scope(state: \.destination?.addChoice, action: \.destination.addChoice)) { store in
            AddChoiceView(store: store)
        }
        .onAppear { store.send(.onAppear) }
        .alert($store.scope(state: \.alert, action: \.alert))
    }

    var submitButton: some View {
        CellarButton("Select \(store.selectedChoices.count)", isDisabled: store.isLoading) {
            store.send(.submitSelectedChoicesButtonTapped)
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

private extension MultipleChoiceSelectionView {
    struct ChoiceView: View {
        let choice: Choice
        let isSelected: Bool

        var store: StoreOf<MultipleChoiceSelection<Choice, IError>>

        var body: some View {
            Button {
                store.send(.choiceSelected(choice))
            } label: {
                HStack {
                    Text(displayName)

                    Spacer()

                    if store.isMultiSelect, isSelected {
                        Image(systemName: "checkmark")
                            .accessibilityHidden(true)
                    }
                }
                .accessibilityHint(isSelected ? "Deselect \(displayName)" : "Select \(displayName)")
                .accessibilityAddTraits(isSelected && store.isMultiSelect ? .isSelected : [])
            }
        }

        var displayName: String {
            store.delegate.getDisplayName(choice)
        }
    }
}

#if DEBUG
private struct Example: Choosable {
    let id = "ID"
    let name = "Xavier Frissant"
}

private enum ExampleEmptyError: ClientError {}

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
        isMultiSelect: false,
        delegate: delegate
    )

    Color.pink.ignoresSafeArea().sheet(isPresented: .constant(true)) {
        NavigationStack {
            MultipleChoiceSelectionView<Example, ExampleEmptyError>(
                store: Store(initialState: state) {
                    MultipleChoiceSelection()
                }
            )
        }
    }
}
#endif
