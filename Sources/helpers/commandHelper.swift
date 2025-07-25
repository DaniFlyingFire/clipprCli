import ArgumentParser
import Noora

class CommandHelper {
    public static func getSettings(_ noora: Noora) throws -> Settings {
        guard let settings = TokenManager.read() else {
            noora.error("Could not read data")
            throw ExitCode.failure
        }
        return settings
    }

    public static func setSettings(_ noora: Noora, _ data: Settings) throws {
        let success = TokenManager.write(data)
        if !success {
            noora.error("Save failed :/")
            throw ExitCode.failure
        }
    }
}