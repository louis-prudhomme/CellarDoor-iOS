import Foundation
import SharedCommonArchitecture
import SharedCommonPictureClient
import WineCommonOcrClient

@Reducer
public struct WineFeatureOcrWine {
    @ObservableState
    public struct State: Equatable {
        var isTakingPicture = false
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
        case ocrCompleted(Result<OcrExtractedData, OcrClientError>)

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)
        case destination(PresentationAction<Destination.Action>)

        /// Handled by the Coordinator
        public enum Delegate: Equatable {}
    }

    public init() {}

    @Reducer
    public enum Destination {
        case extracted(WineFeatureOcrExtracted)
    }

    @Dependency(\.pictureClient.selectPicture) var selectPicture
    @Dependency(\.ocrClient.performOcr) var performOcr

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .takePictureButtonTapped:
                    state.isTakingPicture = true
                    return .run { [selectPicture] send in
                        let result = await selectPicture(.camera)
                        await send(.pictureSelected(result))
                    }

                case .selectFromLibraryButtonTapped:
                    state.isTakingPicture = true
                    return .run { [selectPicture] send in
                        let result = await selectPicture(.photoLibrary)
                        await send(.pictureSelected(result))
                    }

                case let .pictureSelected(.success(data)):
                    state.isTakingPicture = false
                    state.isProcessing = true
                    state.capturedImage = data
                    return .run { [performOcr] send in
                        let result = await performOcr(data)
                        await send(.ocrCompleted(result))
                    }

                case .pictureSelected(.failure(.cancelled)):
                    state.isTakingPicture = false
                    return .none

                case let .pictureSelected(.failure(error)):
                    state.isTakingPicture = false
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
                        extractedData: extractedData.asWineExtractedData
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

// MARK: - Adapters

private extension OcrExtractedData {
    var asWineExtractedData: WineExtractedData {
        WineExtractedData(
            millesime: millesime,
            abv: abv,
            extractedStrings: extractedStrings,
            pictureData: nil
        )
    }
}
