import Foundation

class NetworkService {
    var session: URLSession = .shared

    func request<Response>(_ request: Request<Response>, completion: @escaping (Result<Response>) -> ()) {
        session.dataTask(with: request.toURLRequest(), completionHandler: { (data, response, error) in
            if let data = data {
                completion(request.parse(data))
            } else {
                completion(.error(error!))
            }
        }).resume()
    }
}
