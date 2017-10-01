public enum Platform: String, Codable {
    case ios
    case android
}

public struct App: SnakeCaseCodable {
    // sourcery: keyOverride = "_id"
    public let id: String
    // sourcery: keyOverride = "app_name"
    public let name: String
    public let platform: Platform
    
    public init(id: String, name: String, platform: Platform) {
        self.id = id
        self.name = name
        self.platform = platform
    }
}

public struct Branch: SnakeCaseCodable {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
