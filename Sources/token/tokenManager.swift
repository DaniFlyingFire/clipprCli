import Foundation

class TokenManager 
{

    static let path: String = expandTilde("~/.clippr")

    static func read() -> Settings?
    {
        let url = URL(fileURLWithPath: path)

        guard exists() else {
            return Settings()
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(Settings.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }

    private static func expandTilde(_ path: String) -> String 
    {
        if path.hasPrefix("~") {
            let home = FileManager.default.homeDirectoryForCurrentUser.path
            let index = path.index(after: path.startIndex)
            return home + path[index...]
        }
        return path
    }

    static func write(_ object: Settings) -> Bool 
    {
        let url = URL(fileURLWithPath: path)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(object)
            try data.write(to: url)
            return true
        } catch {
            return false
        }
    }

    static func exists() -> Bool 
    {
        return FileManager.default.fileExists(atPath: path)
    }

    static func getCurrentConfig() -> Config? 
    {
        guard let config = read() else {
            return nil
        }
        guard let active = config.active else {
            return nil
        }
        guard let token = config.tokens[active] else {
            return nil
        }
        return token
    }

}