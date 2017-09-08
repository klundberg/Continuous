public enum Platform: String, Codable {
    case ios
    case android
}

public struct App: Codable {
    // sourcery: keyOverride = "_id"
    public let id: String
    public let appName: String
    public let platform: Platform
}

public struct Branch: Codable {
    public let name: String
}
