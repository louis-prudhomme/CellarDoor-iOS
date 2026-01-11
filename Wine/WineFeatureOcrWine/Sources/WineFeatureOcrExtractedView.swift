import SharedCommonArchitecture
import SharedCommonDesignSystem
import SwiftUI

public struct WineFeatureOcrExtractedView: View {
    @Bindable var store: StoreOf<WineFeatureOcrExtracted>

    public init(store: StoreOf<WineFeatureOcrExtracted>) {
        self.store = store
    }

    public var body: some View {
        extractionResultView(store.extractedData)
            .navigationTitle("Scan Wine Bottle")
    }

    @ViewBuilder
    private func extractionResultView(_ extractedData: OcrExtractedData) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                capturedImageView
                extractedDataSummary(extractedData)
                actionButtons
            }
            .padding()
        }
    }

    @ViewBuilder private var capturedImageView: some View {
        if let image = Image(data: store.capturedImage, label: "Captured wine bottle image") {
            image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            Image(systemName: "photo.badge.exclamationmark")
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
                .frame(height: 120)
                .accessibilityHidden(true)
        }
    }

    @ViewBuilder private var actionButtons: some View {
        VStack(spacing: 12) {
            CellarButton("Continue", systemImage: "arrow.right") {
                store.send(.confirmExtractionButtonTapped)
            }
            .buttonStyle(.borderedProminent)

            Button { store.send(.delegate(.retakeButtonTapped)) } label: {
                Label("Retake Photo", systemImage: "arrow.counterclockwise")
            }
            .buttonStyle(.bordered)
        }
        .controlSize(.large)
    }

    @ViewBuilder
    private func extractedDataSummary(_ extractedData: OcrExtractedData) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Extracted Information")
                .font(.headline)

            extractedDataRow(
                label: "Vintage Year",
                value: extractedData.millesime.map { String($0) },
                icon: "calendar"
            )

            extractedDataRow(
                label: "Alcohol (AbV)",
                value: extractedData.abv.map { String(format: "%.1f%%", $0) },
                icon: "drop.fill"
            )

            if let suggestedName = extractedData.suggestedName {
                extractedDataRow(
                    label: "Possible Name",
                    value: suggestedName,
                    icon: "textformat"
                )
            }

            extractedTextDisclosure(extractedData.extractedStrings)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    @ViewBuilder
    private func extractedTextDisclosure(_ strings: [String]) -> some View {
        if !strings.isEmpty {
            Divider()

            DisclosureGroup {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(strings, id: \.self) { text in
                        Text("• \(text)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
            } label: {
                Label("All Extracted Text", systemImage: "doc.text")
                    .font(.subheadline)
            }
        }
    }

    @ViewBuilder
    private func extractedDataRow(label: String, value: String?, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 24)
                .accessibilityHidden(true)

            Text(label)
                .foregroundStyle(.secondary)

            Spacer()

            if let value {
                Text(value)
                    .fontWeight(.medium)
            } else {
                Text("Not found")
                    .foregroundStyle(.tertiary)
                    .italic()
            }
        }
    }
}

#Preview {
    NavigationStack {
        WineFeatureOcrExtractedView(
            store: Store(initialState: WineFeatureOcrExtracted.State(
                capturedImage: Data(),
                extractedData: OcrExtractedData(
                    millesime: 2_015,
                    abv: 13.5,
                    extractedStrings: [
                        "Château Margaux",
                        "2015",
                        "13.5% ABV",
                        "Bordeaux, France"
                    ]
                )
            )) {
                WineFeatureOcrExtracted()
            }
        )
    }
}
