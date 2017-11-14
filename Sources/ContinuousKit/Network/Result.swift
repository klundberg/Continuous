import Foundation

public enum Result<Value> {
    case value(Value)
    case error(Error)

    public init(evaluate: () throws -> Value) {
        do {
            self = .value(try evaluate())
        } catch {
            self = .error(error)
        }
    }

    public func materialize() throws -> Value {
        switch self {
        case .value(let value): return value
        case .error(let error): throw error
        }
    }

    public func map<Transformed>(_ transform: (Value) -> Transformed) -> Result<Transformed> {
        switch self {
        case .value(let value): return .value(transform(value))
        case .error(let error): return .error(error)
        }
    }

    public func flatMap<Transformed>(_ transform: (Value) -> Result<Transformed>) -> Result<Transformed> {
        switch self {
        case .value(let value): return transform(value)
        case .error(let error): return .error(error)
        }
    }
}
