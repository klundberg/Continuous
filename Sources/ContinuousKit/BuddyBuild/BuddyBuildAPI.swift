import Foundation

class BuddyBuildAPI {
    private static func headers() -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }

    static func apps() -> Request<[App]> {
        return .init(path: "/apps", headers: headers())
    }

    static func branches(appId: String) -> Request<[Branch]> {
        return .init(path: "/apps/\(appId)/branches", headers: headers())
    }
}
