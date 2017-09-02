import Foundation

enum BuildStatus: String, Codable {
    case failed
    case succeeded
    case cancelled
    case pending
    case building
}

struct BuildName: Codable {
    let name: String
}

struct Build: Codable {
    let _id: String
    let app_id: String
    let repo_url: URL
    let build_status: BuildStatus
    let finished: Bool
    let commit_info: CommitInfo
    let buildNumber: Int
    let created_at: Date
    let started_at: Date
    let finished_at: Date
    let test_summary: TestSummary
    let links: [String: Link]
}

struct CommitInfo: Codable {
    let tags: [String]
    let branch: String
    let commit_sha: String
    let author: String
    let message: String
    let html_url: URL
}

struct TestSummary: Codable {
    let tests_count: Int
    let tests_passed: Int
    let code_coverage_percentage: Double
}

struct Link: Codable {
    let name: String
    let url: URL
}
