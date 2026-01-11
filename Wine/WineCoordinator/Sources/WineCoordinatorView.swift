import SharedCommonArchitecture
import SwiftUI
import WineFeatureAddWine
import WineFeatureListWine
import WineFeatureOcrWine
import WineFeatureShowWine

public struct WineCoordinatorView: View {
    @Bindable var store: StoreOf<WineCoordinator>

    public init(store: StoreOf<WineCoordinator>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.destination, action: \.destination)) {
            WineFeatureListWineView(
                store: store.scope(state: \.list, action: \.list)
            )
        } destination: { store in
            switch store.case {
                case let .addWine(store):
                    WineFeatureAddWineView(store: store)
                case let .showWine(store):
                    WineFeatureShowWineView(store: store)
                case let .ocrWine(store):
                    WineFeatureOcrWineView(store: store)
                @unknown default:
                    Text("Unimplemented destination")
            }
        }
    }
}

#Preview {
    WineCoordinatorView(
        store: Store(initialState: WineCoordinator.State()) {
            WineCoordinator()
        }
    )
}
