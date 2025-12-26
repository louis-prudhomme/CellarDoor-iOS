

public enum VoidResult<Failure: Error>: Sendable, Equatable where Failure: Equatable {
    /// A success, storing a `Success` value.
    case success

    /// A failure, storing an error.
    case failure(Failure)

    public init<SuccessType>(body: @Sendable () async -> Result<SuccessType, Failure>) async {
        let res = await body()
        if case let .failure(error) = res {
            self = .failure(error)
        } else {
            self = .success
        }
    }

    public init<SuccessType>(body: @Sendable () -> Result<SuccessType, Failure>) {
        let res = body()
        if case let .failure(error) = res {
            self = .failure(error)
        } else {
            self = .success
        }
    }
}

public extension VoidResult {
    /// Allows to map a `VoidResult` to a `Result` ; if the initial `VoidResult` is a `.success`,
    /// the resulting `Result` will be a `.success(mapped)`
    /// - Parameter mapped: value to map to the `.success`
    /// - Returns: a full-fledged `Result`
    func map<ResultType>(mapped: ResultType) -> Result<ResultType, Failure> {
        switch self {
        case let .failure(error): return .failure(error)
        case .success: return .success(mapped)
        }
    }

    /// Allows to map a `VoidResult` to a `Result` ; if the initial `VoidResult` is a `.success`,
    /// the resulting `Result` will be a `.success(mapper())`
    /// - Parameter mapper: closure providing the value to map to the `.success`
    /// - Returns: a full-fledged `Result`
    func map<ResultType>(mapper: @escaping () -> ResultType) -> Result<ResultType, Failure> {
        switch self {
        case let .failure(error): return .failure(error)
        case .success: return .success(mapper())
        }
    }
}