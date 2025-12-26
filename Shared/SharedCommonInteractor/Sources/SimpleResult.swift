public enum SimpleResult: Equatable {
    case success
    case failure

    public init<SuccessType, ErrorType>(from result: Result<SuccessType, ErrorType>) where ErrorType: Error {
        switch result {
        case .success: self = .success
        case .failure: self = .failure
        }
    }

    public init<SuccessType, ErrorType>(body: @Sendable () async -> Result<SuccessType, ErrorType>) async
        where ErrorType: Error
    {
        self = .init(from: await body())
    }
}