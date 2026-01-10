import SwiftUI
import UIKit

public extension Image {
    @MainActor
    init?(data: Data, label: String? = nil) {
        guard let uiImage = UIImage(data: data) else {
            return nil
        }

        if let label {
            uiImage.accessibilityLabel = label
        }

        self = Image(uiImage: uiImage)
    }
}
