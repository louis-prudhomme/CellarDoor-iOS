import SwiftUI

public struct CellarButton: View {
    let text: Text
    let systemImage: String?
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    public init(_ text: String, systemImage: String? = nil, isLoading: Bool = false, isDisabled: Bool = false, action: @escaping () -> Void) {
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
                } else {
                    if let systemImage {
                        Image(systemName: systemImage)
                    }
                }
            }
        }
        .disabled(isDisabled || isLoading)
    }
}
