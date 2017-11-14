public struct CoverageResults: SnakeCaseCodable {
    public let coverage: Double
    public let buildId: String
    public let targets: [Target]
}

public struct Target: SnakeCaseCodable {
    public let name: String
    public let coverage: Double
}

public enum CoverageOptions: QueryParameterConvertible {
    case none
    case file
    case function

    public func queryParameters() -> [String : String] {
        switch self {
        case .none: return [:]
        case .file: return ["showFileCoverage": "true"]
        case .function: return ["showFunctionCoverage": "true"]
        }
    }
}
