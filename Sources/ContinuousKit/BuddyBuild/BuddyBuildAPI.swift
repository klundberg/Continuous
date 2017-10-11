import Foundation

public enum BuddyBuildAPI {
    private static func headers() -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }

    private static func url(_ path: String, queryParams: [String: String]? = nil) -> URL {
        let baseURL = "https://api.buddybuild.com/v1"
        var components = URLComponents(string: "\(baseURL)\(path)")
        components?.queryItems = queryParams?.flatMap({ key, value in
            return URLQueryItem(name: key, value: value)
        })
        return (components?.url)!
    }

    public static func apps() -> Request<[App]> {
        return .init(url: url("/apps"), headers: headers())
    }

    public static func branches(appId: String) -> Request<[Branch]> {
        return .init(url: url("/apps/\(appId)/branches"), headers: headers())
    }

    public static func builds(appId: String, filter: BuildFilter? = nil) -> Request<[Build]> {
        return .init(url: url("/apps/\(appId)/builds", queryParams: filter?.asDictionary), headers: headers())
    }

    public static func build(buildId: String) -> Request<Build> {
        return .init(url: url("/builds/\(buildId)"), headers: headers())
    }

    public static func latestBuild(appId: String) -> Request<Build> {
        return .init(url: url("/apps/\(appId)/build/latest"), headers: headers())
    }
}

public class BuddyBuild {
    private let key: APIKey
    private let networkService: NetworkService

    public init(key: APIKey, networkService: NetworkService = StandardNetworkService()) {
        self.key = key
        self.networkService = networkService
    }

    func getApps(completion: @escaping (Result<[App]>) -> Void) {
        networkService.request(BuddyBuildAPI.apps(), completion: completion)
    }

    func getBranches(for app: App, completion: @escaping (Result<[Branch]>) -> Void) {
        networkService.request(BuddyBuildAPI.branches(appId: app.id), completion: completion)
    }

    func getBuilds(for app: App, filter: BuildFilter? = nil, completion: @escaping (Result<[Build]>) -> Void) {
        networkService.request(BuddyBuildAPI.builds(appId: app.id, filter: filter), completion: completion)
    }

    func getBuild(for id: String, completion: @escaping (Result<Build>) -> Void) {
        networkService.request(BuddyBuildAPI.build(buildId: id), completion: completion)
    }

    func getLatestBuild(for app: App, completion: @escaping (Result<Build>) -> Void) {
        networkService.request(BuddyBuildAPI.latestBuild(appId: app.id), completion: completion)
    }
}
