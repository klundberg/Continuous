import Foundation

class BuddyBuildAPI {
    private static func headers() -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }

    private static func url(_ path: String) -> URL {
        let baseURL = "https://api.buddybuild.com/v1"
        return URL(string: "\(baseURL)\(path)")!
    }

    static func apps() -> Request<[App]> {
        return .init(url: url("/apps"), headers: headers())
    }

    static func branches(appId: String) -> Request<[Branch]> {
        return .init(url: url("/apps/\(appId)/branches"), headers: headers())
    }
}
