import SwiftUI

public struct CellarButton: View {
    let text: Text
    let systemImage: String?
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    private let buttonText: String

    public init(_ text: String, systemImage: String? = nil, isLoading: Bool = false, isDisabled: Bool = false, action: @escaping () -> Void) {
        buttonText = text
        self.text = Text(text)
        self.systemImage = systemImage
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        Button {
            if !isLoading, !isDisabled {
                action()
            }
        } label: {
            HStack {
                text

                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .accessibilityHidden(true)
                } else {
                    if let systemImage {
                        Image(systemName: systemImage)
                            .accessibilityHidden(true)
                    }
                }
            }
        }
        .disabled(isDisabled || isLoading)
        .accessibilityLabel(accessibilityLabel)
    }

    // MARK: - Accessibility Computed Properties

    private var accessibilityLabel: String {
        if isLoading {
            return "\(buttonText), loading"
        } else {
            return buttonText
        }
    }
}
