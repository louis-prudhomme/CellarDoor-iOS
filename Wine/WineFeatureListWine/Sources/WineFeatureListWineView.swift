import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI
import WineDomain

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
                    ForEach(store.wines) { bottle in
                        WineBottleView(bottle: bottle)
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

extension WineFeatureListWineView {
    struct WineBottleView: View {
        let bottle: WineBottle

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(
                    """
                    \(Text(bottle.name)) - \
                    \(Text(bottle.millesime.formatted(.number.grouping(.never)))
                        .foregroundStyle(.secondary))
                    """
                )
                .font(.headline)

                Text(bottle.grapeVarieties.map(\.name).joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
