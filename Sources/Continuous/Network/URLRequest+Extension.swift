import Foundation

extension URLRequest {
    mutating func addHTTPHeaders(_ headers: HTTPHeaders) {
        for (header, value) in headers {
            addValue(value, forHTTPHeaderField: header)
        }
    }
}
