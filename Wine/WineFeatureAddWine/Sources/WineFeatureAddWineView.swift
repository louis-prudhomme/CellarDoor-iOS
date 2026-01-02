import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureAddWineView: View {
    @Bindable var store: StoreOf<WineFeatureAddWine>

    @Dependency(\.date) private var date

    public init(store: StoreOf<WineFeatureAddWine>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Form {
                HStack(spacing: 16) {
                    Text("Name")

                    TextField("Enter Wine Name", text: $store.name)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                }

                yearPicker

                winemakerSelectionButton

                grapeVarietiesSelectionButton
            }
            .overlay(alignment: .bottom) {
                CellarButton("Add Wine", systemImage: "plus", isLoading: store.isLoading) {
                    store.send(.submitButtonTapped)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .sheet(item: $store.scope(state: \.destination, action: \.destination)) { store in
            switch store.case {
                case let .winemaker(store):
                    MultipleChoiceSelectionView(store: store)
                        .presentationDetents([.medium, .large])

                case let .grapeVarieties(store):
                    MultipleChoiceSelectionView(store: store)
                        .presentationDetents([.medium, .large])
            }
        }
        .navigationTitle("Add a wine")
    }

    @ViewBuilder var yearPicker: some View {
        Picker("Vintage Year", selection: $store.millesime) {
            let currentYear: Int = Calendar.current.component(.year, from: date())
            ForEach(1930...currentYear, id: \.self) { year in
                Text(year.formatted(.number.grouping(.never))).tag(year)
            }
        }
        .pickerStyle(.automatic)
    }

    @ViewBuilder var winemakerSelectionButton: some View {
        Button {
            store.send(.selectWinemakerButtonTapped)
        } label: {
            HStack {
                Text(store.winemaker?.name ?? "Select Winemaker")

                Spacer()

                Image(systemName: store.winemaker == nil ? "chevron.right" : "square.and.pencil")
                    .accessibilityHidden(true)
            }
            .accessibilityHint("Select or edit the winemaker")
            .cornerRadius(8)
        }
    }

    @ViewBuilder var grapeVarietiesSelectionButton: some View {
        Button {
            store.send(.selectGrapeVarietiesButtonTapped)
        } label: {
            HStack {
                Text(store.grapeVarieties.isEmpty ? "Select Grape varieties" : store.grapeVarieties.map(\.name).joined(separator: ", "))

                Spacer()

                Image(systemName: store.grapeVarieties.isEmpty ? "chevron.right" : "square.and.pencil")
                    .accessibilityHidden(true)
            }
            .accessibilityHint("Select or edit grape varieties")
            .cornerRadius(8)
        }
    }
}

#Preview {
    NavigationStack {
        WineFeatureAddWineView(
            store: Store(initialState: WineFeatureAddWine.State()) {
                WineFeatureAddWine()
            }
        )
    }
}
