import SharedCommonArchitecture
import SwiftUI
import WineCoordinator

public struct AppCoordinatorView: View {
    @Bindable var store: StoreOf<AppCoordinator>

    public init(store: StoreOf<AppCoordinator>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Button("Go to wines") {
                store.send(.navigateToWines)
            }
        }
        .fullScreenCover(item: $store.scope(state: \.destination, action: \.destination)) { store in
            switch store.case {
                case let .wines(store):
                    WineCoordinatorView(store: store)
                @unknown default:
                    Text("Unknown destination")
            }
        }
    }
}

#Preview {
    AppCoordinatorView(
        store: Store(initialState: AppCoordinator.State()) {
            AppCoordinator()
        }
    )
}
