import SharedCommonArchitecture
import SharedCommonPictureClient
import UIKit
import Vision

@Reducer
public struct WineFeatureOcrExtracted {
    @ObservableState
    public struct State: Equatable {
        var capturedImage: Data
        var extractedData: OcrExtractedData

        public init(capturedImage: Data, extractedData: OcrExtractedData) {
            self.capturedImage = capturedImage
            self.extractedData = extractedData
        }
    }

    public enum Action: BindableAction {
        case confirmExtractionButtonTapped

        case alert(PresentationAction<Never>)
        case binding(BindingAction<State>)
        case delegate(Delegate)

        /// Handled by the Coordinator
        public enum Delegate: Equatable {
            case extractedDataConfirmed(OcrExtractedData)
            case retakeButtonTapped
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .confirmExtractionButtonTapped:
                    state.extractedData.pictureData = state.capturedImage
                    return .send(.delegate(.extractedDataConfirmed(state.extractedData)))

                case .alert:
                    return .none

                case .binding:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}
