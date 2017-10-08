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

    
}
