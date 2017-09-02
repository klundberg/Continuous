enum Platform: String, Codable {
    case ios
    case android
}

struct App: Codable {
    let id: String
    let appName: String
    let platform: Platform

    enum CodingKeys: String, CodingKey {
        case id = "_id", appName = "app_name", platform
    }
}

struct Branch: Codable {
    let name: String
}
