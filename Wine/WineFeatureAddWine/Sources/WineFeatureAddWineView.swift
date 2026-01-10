import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureAddWineView: View {
    @Bindable var store: StoreOf<WineFeatureAddWine>

    @Dependency(\.date) private var date
    @Dependency(\.calendar) var calendar

    public init(store: StoreOf<WineFeatureAddWine>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Form {
                pictureSection

                HStack(spacing: 16) {
                    Text("Name")

                    TextField("Enter Wine Name", text: $store.name)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                }

                HStack(spacing: 16) {
                    Text("AbV (%)")

                    TextField("Enter AbV", value: $store.abv, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                }

                yearPicker

                winemakerSelectionButton

                grapeVarietiesSelectionButton

                bottlingLocationSelectionButton
            }
            .overlay(alignment: .bottom) {
                CellarButton("Create \(store.name)", systemImage: "plus", isLoading: store.isLoading) {
                    store.send(.submitButtonTapped)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .sheet(item: $store.scope(state: \.destination, action: \.destination)) { store in
            NavigationStack {
                switch store.case {
                    case let .winemaker(store):
                        MultipleChoiceSelectionView(store: store)
                            .presentationDetents([.medium, .large])

                    case let .grapeVarieties(store):
                        MultipleChoiceSelectionView(store: store)
                            .presentationDetents([.medium, .large])

                    case let .bottlingLocation(store):
                        BottlingLocationSelectionView(store: store)
                            .presentationDetents([.medium, .large])
                }
            }
        }
        .navigationTitle("Add a wine")
    }

    @ViewBuilder var yearPicker: some View {
        Picker("Vintage Year", selection: $store.millesime) {
            let currentYear: Int = calendar.component(.year, from: date())
            ForEach(1_930 ... currentYear, id: \.self) { year in
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
        }
    }

    @ViewBuilder var bottlingLocationSelectionButton: some View {
        Button {
            store.send(.selectBottlingLocationButtonTapped)
        } label: {
            HStack {
                Text(store.bottlingLocation?.name ?? "Select Bottling Location")

                Spacer()

                Image(systemName: store.bottlingLocation == nil ? "chevron.right" : "square.and.pencil")
                    .accessibilityHidden(true)
            }
            .accessibilityHint("Select or edit the bottling location")
        }
    }

    @ViewBuilder var pictureSection: some View {
        Section {
            VStack(spacing: 12) {
                if let pictureData = store.picture, let image = Image(data: pictureData, label: pictureAccessibilityLabel) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .accessibilityLabel(pictureAccessibilityLabel)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                        .frame(height: 120)
                        .accessibilityHidden(true)
                }

                HStack(spacing: 12) {
                    Button { store.send(.selectPictureFromCameraButtonTapped) } label: {
                        Label("Camera", systemImage: "camera")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)

                    Button { store.send(.selectPictureFromLibraryButtonTapped) } label: {
                        Label("Library", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.vertical, 8)
        }
    }

    private var pictureAccessibilityLabel: String {
        if !store.name.isEmpty {
            "Picture of \(store.name)"
        } else {
            "Picture of the wine bottle"
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
