import SharedCommonArchitecture
import SwiftUI
import WineCoordinator

public struct AppCoordinatorView: View {
    var store: StoreOf<AppCoordinator>

    public init(store: StoreOf<AppCoordinator>) {
        self.store = store
    }

    public var body: some View {
        if let destination = store.destination {
            switch destination {
                case .wines:
                    if let wineStore = store.scope(state: \.destination?.wines, action: \.destination.wines) {
                        WineCoordinatorView(store: wineStore)
                    }
            }
        } else {
            VStack {
                Text("Pick a door")
                    .font(.largeTitle)

                Button("Go to wines") {
                    store.send(.navigateToWines)
                }
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
