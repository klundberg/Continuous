import Foundation

enum Result<Value> {
    case value(Value)
    case error(Error)
}

extension Result {
    init(_ evaluate: () throws -> Value) {
        do {
            self = .value(try evaluate())
        } catch {
            self = .error(error)
        }
    }
}
