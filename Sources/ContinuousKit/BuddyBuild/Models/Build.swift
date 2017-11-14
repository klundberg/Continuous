import Foundation

public enum BuildStatus: String, Codable {
    case cancelled
    case failed
    case queued
    case running
    case success
}

public struct BuildFilter: QueryParameterConvertible {
    public var branch: String?
    public var scheme: String?
    public var status: BuildStatus?
    public var limit: Int?

    public func queryParameters() -> [String : String] {
        var dict: [String: String] = [:]
        if let branch = branch {
            dict["branch"] = branch
        }
        if let scheme = scheme {
            dict["scheme"] = scheme
        }
        if let status = status {
            dict["status"] = status.rawValue
        }
        if let limit = limit {
            dict["limit"] = String(limit)
        }
        return dict
    }
}

public struct Build: SnakeCaseCodable {
    // sourcery: keyOverride = "_id"
    public let id: String
    public let appId: String
    public let repoUrl: URL
    public let buildStatus: BuildStatus
    public let finished: Bool
    public let commitInfo: CommitInfo
    public let buildNumber: Int
    public let createdAt: Date?
    public let startedAt: Date?
    public let finishedAt: Date?
    public let testSummary: TestSummary
    public let links: [String: [Link]]
}

public struct CommitInfo: SnakeCaseCodable {
    public let tags: [String]
    public let branch: String
    public let commitSha: String
    public let author: String
    public let message: String
    public let htmlUrl: URL
}

public struct TestSummary: SnakeCaseCodable {
    public let testsCount: Int?
    public let testsPassed: Int?
    public let codeCoveragePercentage: Double?
}

public struct Link: SnakeCaseCodable {
    public let name: String
    public let url: URL
}
