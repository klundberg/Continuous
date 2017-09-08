import Foundation

public enum BuildStatus: String, Codable {
    case pending
    case cancelled
    case building
    case succeeded
    case failed
}

public struct BuildName: Codable {
    public let name: String
}

public struct Build: Codable {
    // sourcery: keyOverride = "_id"
    public let id: String
    public let appId: String
    public let repoUrl: URL
    public let buildStatus: BuildStatus
    public let finished: Bool
    public let commitInfo: CommitInfo
    public let buildNumber: Int
    public let createdAt: Date
    public let startedAt: Date
    public let finishedAt: Date
    public let testSummary: TestSummary
    public let links: [String: Link]
}

public struct CommitInfo: Codable {
    public let tags: [String]
    public let branch: String
    public let commitSha: String
    public let author: String
    public let message: String
    public let htmlUrl: URL
}

public struct TestSummary: Codable {
    public let testsCount: Int
    public let testsPassed: Int
    public let codeCoveragePercentage: Double
}

public struct Link: Codable {
    public let name: String
    public let url: URL
}
