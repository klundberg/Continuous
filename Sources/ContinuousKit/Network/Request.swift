import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

typealias HTTPHeaders = [String: String]

struct Request<Response> {
    typealias Parser = (Data) -> Result<Response>

    let url: URL
    let method: HTTPMethod
    let headers: HTTPHeaders
    let parse: Parser

    init(url: URL, method: HTTPMethod = .GET, headers: HTTPHeaders = [:], parse: @escaping Parser) {
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
    init(url: URL, method: HTTPMethod = .GET, headers: [String: String] = [:]) {
        self.init(url: url, method: method, headers: headers) { (data) -> Result<Response> in
            return Result(evaluate: { try JSONDecoder().decode(Response.self, from: data) })
        }
    }
}
