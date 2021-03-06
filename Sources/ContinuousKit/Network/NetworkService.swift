import Foundation

public protocol NetworkService {
    func request<Response>(_ request: Request<Response>, completion: @escaping (Result<Response>) -> ())
}

public class StandardNetworkService: NetworkService {
    public var session: URLSession = .shared

    public init() {}

    public func request<Response>(_ request: Request<Response>, completion: @escaping (Result<Response>) -> ()) {
        session.dataTask(with: request.toURLRequest(), completionHandler: { (data, response, error) in
            completion(data.map(request.parse) ?? .error(error!))
        }).resume()
    }
}
