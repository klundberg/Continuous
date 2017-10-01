import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

typealias HTTPHeaders = [String: String]

struct Request<Response> {
    typealias Parser = (Data) -> Result<Response>

    private let baseURL = "https://api.buddybuild.com/v1"
    let url: URL
    let method: HTTPMethod
    let headers: HTTPHeaders
    let parse: Parser

    init(path: String, method: HTTPMethod = .GET, headers: HTTPHeaders = [:], parse: @escaping Parser) {
        self.url = URL(string: "\(baseURL)\(path)")!
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
    init(path: String, method: HTTPMethod = .GET, headers: [String: String] = [:]) {
        self.init(path: path, method: method, headers: headers) { (data) -> Result<Response> in
            return Result({ try JSONDecoder().decode(Response.self, from: data) })
        }
    }
}
