import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureListWineView: View {
    @Bindable var store: StoreOf<WineFeatureListWine>

    public init(store: StoreOf<WineFeatureListWine>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            if store.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(store.wines) { wine in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(wine.name)
                                .font(.headline)
                            Text("Vintage: \(wine.millesime)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .task { store.send(.screenAppeared) }
        .refreshable { store.send(.screenPulled) }
        .navigationTitle("Wines")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Return to Root", systemImage: "xmark") {
                    store.send(.delegate(.popToRoot))
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add a wine", systemImage: "plus") {
                    store.send(.delegate(.addButtonTapped))
                }
            }
        }
    }
}

#Preview {
    WineFeatureListWineView(
        store: Store(initialState: WineFeatureListWine.State()) {
            WineFeatureListWine()
        }
    )
}
