import Foundation

public struct DeploymentGroup: SnakeCaseCodable {
    // sourcery: keyOverride = "_id"
    public let id: String
    public let name: String
    public let branch: String
    public let testers: [String]
}
