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

struct Request<Response: Decodable> {
    private let baseURL = "https://api.buddybuild.com/v1"
    let url: URL

    init(path: String) {
        self.url = URL(string: "\(baseURL)\(path)")!
    }

    func toURLRequest(withToken token: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

func appsRequest() -> Request<[App]> {
    return .init(path: "/apps")
}

func branchesRequest(appId: String) -> Request<[Branch]> {
    return .init(path: "/apps/\(appId)/branches")
}

class BuddyBuildAPI {
    let token = "<secret>"

    var session: URLSession = .shared

    func request<Response>(_ request: Request<Response>, completion: @escaping (Result<Response>) -> ()) {
        let urlrequest = request.toURLRequest(withToken: token)

        session.dataTask(with: urlrequest, completionHandler: { (data, response, error) in
            guard let data = data else {
                completion(.error(error!))
                return
            }

            completion(Result({ try JSONDecoder().decode(Response.self, from: data) }))
        }).resume()
    }
}
