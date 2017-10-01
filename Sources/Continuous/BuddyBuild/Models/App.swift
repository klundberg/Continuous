public enum Platform: String, Codable {
    case ios
    case android
}

public struct App: SnakeCaseCodable {
    // sourcery: keyOverride = "_id"
    public let id: String
    public let appName: String
    public let platform: Platform
}

public struct Branch: SnakeCaseCodable {
    public let name: String
}
