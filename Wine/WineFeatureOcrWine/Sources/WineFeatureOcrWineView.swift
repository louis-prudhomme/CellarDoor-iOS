import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureOcrWineView: View {
    @Bindable var store: StoreOf<WineFeatureOcrWine>

    public init(store: StoreOf<WineFeatureOcrWine>) {
        self.store = store
    }

    public var body: some View {
        captureView
            .sheet(item: $store.scope(state: \.destination?.extracted, action: \.destination.extracted)) { store in
                WineFeatureOcrExtractedView(store: store)
            }
            .navigationTitle("Scan Wine Bottle")
            .alert($store.scope(state: \.alert, action: \.alert))
    }

    @ViewBuilder private var captureView: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 16) {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 80))
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)

                Text("Take a photo of your wine label")
                    .font(.headline)
                    .multilineTextAlignment(.center)

                Text("We'll extract the vintage year, alcohol content, and other details automatically.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()

            if store.isTakingPicture {
                ProgressView("Taking picture...")
                    .padding()
            } else if store.isProcessing {
                ProgressView("Processing image...")
                    .padding()
            } else {
                VStack(spacing: 12) {
                    Button {
                        store.send(.takePictureButtonTapped)
                    } label: {
                        Label("Take Photo", systemImage: "camera.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)

                    Button {
                        store.send(.selectFromLibraryButtonTapped)
                    } label: {
                        Label("Choose from Library", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        WineFeatureOcrWineView(
            store: Store(initialState: WineFeatureOcrWine.State()) {
                WineFeatureOcrWine()
            }
        )
    }
}
