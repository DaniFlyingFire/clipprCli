struct Settings : Codable
{
    var active: String? = nil
    var tokens: [String: Config] = [:]
}