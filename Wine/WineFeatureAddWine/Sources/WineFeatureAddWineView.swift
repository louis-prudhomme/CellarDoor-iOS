import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureAddWineView: View {
    @Bindable var store: StoreOf<WineFeatureAddWine>

    public init(store: StoreOf<WineFeatureAddWine>) {
        self.store = store
    }

    public var body: some View {
        VStack(alignment: .center) {
            TextField("Enter Wine Name", text: $store.name)
                .textFieldStyle(.roundedBorder)
                .padding()

            TextField("Vintage Year", value: $store.millesime, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()

            winemakerSelectionButton

            Spacer()

            CellarButton("Add Wine", systemImage: "plus", isLoading: store.isLoading) {
                store.send(.submitButtonTapped)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .alert($store.scope(state: \.alert, action: \.alert))
        .sheet(item: $store.scope(state: \.winemakerSheet, action: \.winemakerSheet)) { store in
            MultipleChoiceSelectionView(store: store)
                .presentationDetents([.medium, .large])
        }
        .navigationTitle("Add a wine")
    }

    @ViewBuilder var winemakerSelectionButton: some View {
        Button {
            store.send(.selectWinemakerButtonTapped)
        } label: {
            HStack {
                Text(store.winemaker?.name ?? "Select Winemaker")

                Spacer()

                Image(systemName: store.winemaker == nil ? "chevron.right" : "square.and.pencil")
            }
            .padding()
            .cornerRadius(8)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    WineFeatureAddWineView(
        store: Store(initialState: WineFeatureAddWine.State()) {
            WineFeatureAddWine()
        }
    )
}
