public enum SimpleResult: Equatable {
    case success
    case failure

    public init(from result: Result<some Any, some Error>) {
        switch result {
            case .success: self = .success
            case .failure: self = .failure
        }
    }

    public init(body: @Sendable () async -> Result<some Any, some Error>) async {
        self = await .init(from: body())
    }
}
