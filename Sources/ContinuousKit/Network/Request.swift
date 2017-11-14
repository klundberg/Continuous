import Foundation

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

public typealias HTTPHeaders = [String: String]

public struct Request<Response> {
    public typealias Parser = (Data) -> Result<Response>

    public let url: URL
    public let method: HTTPMethod
    public let headers: HTTPHeaders
    public let parse: Parser

    public init(url: URL, method: HTTPMethod = .GET, headers: HTTPHeaders = [:], parse: @escaping Parser) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parse = parse
    }

    func toURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addHTTPHeaders(headers)
        return request
    }
}

extension Request where Response: Decodable {
    public init(url: URL, method: HTTPMethod = .GET, headers: [String: String] = [:]) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        self.init(url: url, method: method, headers: headers) { (data) -> Result<Response> in
            return Result(evaluate: { try decoder.decode(Response.self, from: data) })
        }
    }
}
