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
        List {
            ForEach(store.wines) { bottle in
                WineBottleView(store: store, bottle: bottle)
            }
        }
        .loadable(isLoading: store.isLoading)
        .alert($store.scope(state: \.alert, action: \.alert))
        .overlay { emptyDisplay }
        .navigationTitle("Wines")
        .toolbar { toolbarContent }
        .refreshable { store.send(.screenPulled) }
        .onAppear { store.send(.screenAppeared) }
    }

    @ViewBuilder var emptyDisplay: some View {
        if !store.isLoading, store.wines.isEmpty {
            ContentUnavailableView(
                "No wines yet.",
                systemImage: "arrow.up.right",
                description: Text("Try adding some!")
            )
            .symbolVariant(.none)
        }
    }

    @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Return to Root", systemImage: "xmark") {
                store.send(.delegate(.popToRoot))
            }
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Scan wine label", systemImage: "camera.viewfinder") {
                store.send(.delegate(.ocrButtonTapped))
            }

            Button("Add a wine", systemImage: "plus") {
                store.send(.delegate(.addButtonTapped))
            }
        }
    }
}

extension WineFeatureListWineView {
    struct WineBottleView: View {
        @Environment(\.layoutDirection) var layoutDirection

        let store: StoreOf<WineFeatureListWine>
        let bottle: WineBottle

        var body: some View {
            Button {
                store.send(.delegate(.wineTapped(bottle)))
            } label: {
                HStack {
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

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityHint(Text("Tap to see more details."))
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
