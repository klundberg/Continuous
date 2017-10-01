import Foundation

public enum BuddyBuildAPI {
    private static func headers() -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }

    private static func url(_ path: String) -> URL {
        let baseURL = "https://api.buddybuild.com/v1"
        return URL(string: "\(baseURL)\(path)")!
    }

    public static func apps() -> Request<[App]> {
        return .init(url: url("/apps"), headers: headers())
    }

    public static func branches(appId: String) -> Request<[Branch]> {
        return .init(url: url("/apps/\(appId)/branches"), headers: headers())
    }
}
