import SharedCommonArchitecture
import SharedCommonPictureClient
import UIKit
import Vision

@Reducer
public struct WineFeatureOcrWine {
    @ObservableState
    public struct State: Equatable {
        var isProcessing = false
        var capturedImage: Data?

        @Presents var alert: AlertState<Never>?
        @Presents var destination: Destination.State?

        public init() {}
    }

    public enum Action: BindableAction {
        case takePictureButtonTapped
        case selectFromLibraryButtonTapped
        case pictureSelected(Result<Data, PictureClientError>)
        case ocrCompleted(Result<OcrExtractedData, OcrError>)

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)
        case destination(PresentationAction<Destination.Action>)

        /// Handled by the Coordinator
        public enum Delegate: Equatable {}
    }

    public enum OcrError: Error, Equatable, LocalizedError {
        case noTextFound
        case processingFailed(String)

        public var errorDescription: String? {
            switch self {
                case .noTextFound:
                    return "No text was found in the image. Please try again with a clearer picture."
                case let .processingFailed(message):
                    return "Failed to process image: \(message)"
            }
        }
    }

    public init() {}

    @Reducer
    public enum Destination {
        case extracted(WineFeatureOcrExtracted)
    }

    @Dependency(\.pictureClient.selectPicture) var selectPicture

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .takePictureButtonTapped:
                    state.isProcessing = true
                    return .run { [selectPicture] send in
                        let result = await selectPicture(.camera)
                        await send(.pictureSelected(result))
                    }

                case .selectFromLibraryButtonTapped:
                    state.isProcessing = true
                    return .run { [selectPicture] send in
                        let result = await selectPicture(.photoLibrary)
                        await send(.pictureSelected(result))
                    }

                case let .pictureSelected(.success(data)):
                    state.capturedImage = data
                    return .run { send in
                        let result = await performOcr(on: data)
                        await send(.ocrCompleted(result))
                    }

                case .pictureSelected(.failure(.cancelled)):
                    state.isProcessing = false
                    return .none

                case let .pictureSelected(.failure(error)):
                    state.isProcessing = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case let .ocrCompleted(.success(extractedData)):
                    state.isProcessing = false
                    guard let capturedImage = state.capturedImage else {
                        state.alert = AlertState {
                            TextState("Internal error: captured image data is missing.")
                        }
                        return .none
                    }

                    state.destination = .extracted(WineFeatureOcrExtracted.State(
                        capturedImage: capturedImage,
                        extractedData: extractedData
                    ))
                    return .none

                case let .ocrCompleted(.failure(error)):
                    state.isProcessing = false
                    state.alert = AlertState {
                        TextState(error.localizedDescription)
                    }
                    return .none

                case .destination(.presented(.extracted(.delegate(.retakeButtonTapped)))):
                    state.destination = nil
                    state.capturedImage = nil
                    return .none

                case .destination:
                    return .none

                case .alert:
                    return .none

                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

// MARK: - Conformances

extension WineFeatureOcrWine.Destination.State: Equatable {}

// MARK: - OCR Processing

private func performOcr(on imageData: Data) async -> Result<OcrExtractedData, WineFeatureOcrWine.OcrError> {
    guard let cgImage = createCGImage(from: imageData) else {
        return .failure(.processingFailed("Could not create image from data"))
    }

    return await withCheckedContinuation { continuation in
        let request = VNRecognizeTextRequest { request, error in
            if let error {
                continuation.resume(returning: .failure(.processingFailed(error.localizedDescription)))
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation], !observations.isEmpty else {
                continuation.resume(returning: .failure(.noTextFound))
                return
            }

            let extractedData = processOcrObservations(observations, pictureData: imageData)
            continuation.resume(returning: .success(extractedData))
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["fr-FR", "en-US"]
        request.usesLanguageCorrection = true

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        do {
            try handler.perform([request])
        } catch {
            continuation.resume(returning: .failure(.processingFailed(error.localizedDescription)))
        }
    }
}

private func createCGImage(from data: Data) -> CGImage? {
    UIImage(data: data)?.cgImage
}

private func processOcrObservations(_ observations: [VNRecognizedTextObservation], pictureData: Data) -> OcrExtractedData {
    var allStrings = [String]()
    var millesime: Int?
    var abv: Double?

    let yearPattern = /\b(19|20)\d{2}\b/
    let abvPattern = /\b(\d{1,2}([.,]\d{1,2})?)\s*(%|vol|°)/

    for observation in observations {
        guard let candidate = observation.topCandidates(1).first else { continue }

        let text = candidate.string.trimmingCharacters(in: .whitespacesAndNewlines)

        if !text.isEmpty {
            allStrings.append(text)

            // Try to extract year (millesime)
            if millesime == nil, let match = text.firstMatch(of: yearPattern) {
                millesime = Int(match.0)
            }

            // Try to extract AbV
            if abv == nil, let match = text.firstMatch(of: abvPattern) {
                let abvString = String(match.1).replacingOccurrences(of: ",", with: ".")
                abv = Double(abvString)
            }
        }
    }

    return OcrExtractedData(
        millesime: millesime,
        abv: abv,
        extractedStrings: allStrings,
        pictureData: pictureData
    )
}
