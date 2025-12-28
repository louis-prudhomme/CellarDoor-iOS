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
            Spacer()

            TextField("Enter Wine Name", text: $store.name)
                .textFieldStyle(.roundedBorder)
                .padding()

            CellarButton("Add Wine", systemImage: "plus", isLoading: store.isLoading) {
                store.send(.submitButtonTapped)
            }
            .buttonStyle(.borderedProminent)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .navigationTitle("Add a wine")
    }
}

#Preview {
    WineFeatureAddWineView(
        store: Store(initialState: WineFeatureAddWine.State()) {
            WineFeatureAddWine()
        }
    )
}
