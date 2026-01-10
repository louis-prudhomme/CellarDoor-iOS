import Foundation
import SharedCommonDependencies
import UIKit

extension PictureClient {
    static let mock = PictureClient(
        selectPicture: { _ in
            fatalError("PictureClient.selectPicture")
        },
        compressPicture: { _, _ in
            fatalError("PictureClient.compressPicture")
        }
    )
}

// MARK: - Mock Data for Testing

public extension PictureClient {
    static let mockWithData = PictureClient(
        selectPicture: { _ in
            // Create a simple 1x1 red pixel image for testing
            let size = CGSize(width: 1, height: 1)
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { context in
                UIColor.red.setFill()
                context.fill(CGRect(origin: .zero, size: size))
            }

            guard let data = image.jpegData(compressionQuality: 0.8) else {
                return .failure(.invalidData)
            }

            return .success(data)
        },
        compressPicture: { data, quality in
            guard let image = UIImage(data: data),
                  let compressedData = image.jpegData(compressionQuality: quality)
            else {
                return .failure(.compressionFailed)
            }

            return .success(compressedData)
        }
    )

    static let mockWithError = PictureClient(
        selectPicture: { _ in
            return .failure(.cancelled)
        },
        compressPicture: { _, _ in
            return .failure(.compressionFailed)
        }
    )
}
