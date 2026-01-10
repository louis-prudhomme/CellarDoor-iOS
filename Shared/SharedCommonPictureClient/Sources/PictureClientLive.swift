import Foundation
import PhotosUI
import SharedCommonDependencies
import SwiftUI
import UIKit

extension PictureClient {
    static let live = PictureClient(
        selectPicture: { source in
            await withCheckedContinuation { continuation in
                Task { @MainActor in
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let rootViewController = windowScene.windows.first?.rootViewController
                    else {
                        continuation.resume(returning: .failure(.unknown(message: "Could not find root view controller")))
                        return
                    }

                    let coordinator = PicturePickerCoordinator(continuation: continuation, source: source)

                    if source == .camera {
                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                            continuation.resume(returning: .failure(.sourceNotAvailable))
                            return
                        }

                        let picker = UIImagePickerController()
                        picker.sourceType = .camera
                        picker.delegate = coordinator
                        coordinator.retain()
                        rootViewController.present(picker, animated: true)
                    } else {
                        var configuration = PHPickerConfiguration()
                        configuration.selectionLimit = 1
                        configuration.filter = .images

                        let picker = PHPickerViewController(configuration: configuration)
                        picker.delegate = coordinator
                        coordinator.retain()
                        rootViewController.present(picker, animated: true)
                    }
                }
            }
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
}

// MARK: - Coordinator

@MainActor
private class PicturePickerCoordinator: NSObject, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    var continuation: CheckedContinuation<Result<Data, PictureClientError>, Never>?
    let source: PictureSource
    private static var retainedCoordinators = Set<PicturePickerCoordinator>()

    init(continuation: CheckedContinuation<Result<Data, PictureClientError>, Never>, source: PictureSource) {
        self.continuation = continuation
        self.source = source
        super.init()
    }

    func retain() {
        Self.retainedCoordinators.insert(self)
    }

    private func release() {
        Self.retainedCoordinators.remove(self)
    }

    // MARK: - UIImagePickerControllerDelegate

    nonisolated func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        Task { @MainActor in
            picker.dismiss(animated: true)

            guard let image,
                  let data = image.jpegData(compressionQuality: 0.8)
            else {
                continuation?.resume(returning: .failure(.invalidData))
                release()
                return
            }

            continuation?.resume(returning: .success(data))
            release()
        }
    }

    nonisolated func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Task { @MainActor in
            picker.dismiss(animated: true)
            continuation?.resume(returning: .failure(.cancelled))
            release()
        }
    }

    // MARK: - PHPickerViewControllerDelegate

    nonisolated func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider else {
            Task { @MainActor in
                picker.dismiss(animated: true)
                continuation?.resume(returning: .failure(.cancelled))
                release()
            }
            return
        }

        Task { @MainActor in
            picker.dismiss(animated: true)
        }

        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            let image = object as? UIImage
            let errorMessage = error?.localizedDescription
            Task { @MainActor in
                guard let self else { return }

                if let errorMessage {
                    self.continuation?.resume(returning: .failure(.unknown(message: errorMessage)))
                    self.release()
                    return
                }

                guard let image,
                      let data = image.jpegData(compressionQuality: 0.8)
                else {
                    self.continuation?.resume(returning: .failure(.invalidData))
                    self.release()
                    return
                }

                self.continuation?.resume(returning: .success(data))
                self.release()
            }
        }
    }
}

// MARK: - Hashable for Coordinator

extension PicturePickerCoordinator {
    static func == (lhs: PicturePickerCoordinator, rhs: PicturePickerCoordinator) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    override nonisolated var hash: Int {
        ObjectIdentifier(self).hashValue
    }
}
