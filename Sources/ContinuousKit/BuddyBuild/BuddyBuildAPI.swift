import Foundation

public protocol QueryParameterConvertible {
    func queryParameters() -> [String: String]
}

public class BuddyBuild {
    private let baseURL = "https://api.buddybuild.com/v1"
    private let key: APIKey
    private let networkService: NetworkService

    public init(key: APIKey, networkService: NetworkService = StandardNetworkService()) {
        self.key = key
        self.networkService = networkService
    }

    public enum Requests {
//
//        public static func coverage(buildId: String) -> Request<CoverageResults> {
//            return .init(url: url("/builds/\(buildId)/coverage"), headers: headers())
//        }
    }

    private func headers() -> [String: String] {
        return ["Authorization": "Bearer \(key)"]
    }

    private func makeURL(_ path: String, queryParams: QueryParameterConvertible? = nil) -> URL {
        var components = URLComponents(string: "\(baseURL)\(path)")!
        components.queryItems = queryParams?.queryParameters().flatMap({ key, value in
            return URLQueryItem(name: key, value: value)
        })
        return components.url!
    }

    public typealias Completion<Response> = (Result<Response>) -> Void

    private func makeRequest<Response: Decodable>(path: String, queryParams: QueryParameterConvertible? = nil) -> Request<Response> {
        return Request(url: makeURL(path, queryParams: queryParams), headers: headers())
    }

    public func getApps(completion: @escaping Completion<[App]>) {
        networkService.request(makeRequest(path: "/apps"), completion: completion)
    }

    public func getBranches(for app: App, completion: @escaping Completion<[Branch]>) {
        networkService.request(makeRequest(path: "/apps/\(app.id)/branches"), completion: completion)
    }

    public func getBuilds(for app: App, filter: BuildFilter? = nil, completion: @escaping Completion<[Build]>) {
        networkService.request(makeRequest(path: "/apps/\(app.id)/builds", queryParams: filter), completion: completion)
    }

    public func getBuild(for id: String, completion: @escaping Completion<Build>) {
        networkService.request(makeRequest(path: "/builds/\(id)"), completion: completion)
    }

    public func getLatestBuild(for app: App, filter: BuildFilter? = nil, completion: @escaping Completion<Build>) {
        networkService.request(makeRequest(path: "/apps/\(app.id)/build/latest", queryParams: filter), completion: completion)
    }

    public func getTestResults(for build: Build, filter: TestFilter? = nil, completion: @escaping Completion<TestResults>) {
        networkService.request(makeRequest(path: "/builds/\(build.id)/tests", queryParams: filter), completion: completion)
    }

    public func getCoverage(for build: Build, options: CoverageOptions, completion: @escaping Completion<CoverageResults>) {
        networkService.request(makeRequest(path: "/builds/\(build.id)/coverage", queryParams: options), completion: completion)
    }
}
