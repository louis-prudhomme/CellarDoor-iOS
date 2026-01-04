import SharedCommonArchitecture
import SharedCommonDependencies
import SharedCommonDesignSystem
import SwiftUI
import WineCommonLocationClient

struct BottlingLocationSelectionView: View {
    @Bindable var store: StoreOf<BottlingLocationSelection>

    init(store: StoreOf<BottlingLocationSelection>) {
        self.store = store
    }

    var body: some View {
        List(store.suggestedLocations, id: \.id) { location in
            Button {
                store.send(.locationSelected(location))
            } label: {
                LocationView(location: location)
            }
        }
        .emptyable(store.suggestedLocations, searchText: store.searchText, isLoading: store.isLoading)
        .onAppear { store.send(.onAppear) }
        .loadable(isLoading: store.isLoading)
        .searchable(text: $store.searchText)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .alert($store.scope(state: \.alert, action: \.alert))
    }

    private var navigationTitle: String {
        if let existing = store.existing {
            "Replace \(existing)"
        } else {
            "Select Bottling Location"
        }
    }
}

// MARK: - Display locations

private extension BottlingLocationSelectionView {
    struct LocationView: View {
        let location: Location

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
                    .font(.headline)

                Text("\(Text(location.countryAsEmoji)) \(Text(location.region))")
                    .font(.subheadline)
                    .accessibilityLabel("\(location.region), \(location.country)")

                ForEach(location.administrativeDivisions, id: \.code) { division in
                    Text("\(division.name) (\(division.code))")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityHint("Select \(location.name) as bottling location")
        }
    }
}

// TODO: refactor into Location
private extension Location {
    var countryCode: String? {
        administrativeDivisions
            .first { $0.type == .country }?
            .code
    }

    var countryAsEmoji: String {
        let baseFlagScalar: UInt32 = 127_397

        guard let countryCode else { return "🏴" }

        return countryCode
            .uppercased()
            .unicodeScalars
            .compactMap { scalar in
                return UnicodeScalar(baseFlagScalar + scalar.value)
            }
            .map { String($0) }
            .joined()
    }

    var region: String {
        administrativeDivisions
            .first { $0.type == .region }?
            .name ?? "Unknown region"
    }

    var country: String {
        administrativeDivisions
            .first { $0.type == .country }?
            .name ?? "Unknown region"
    }
}
