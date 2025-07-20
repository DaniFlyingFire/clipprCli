import ArgumentParser
import Foundation

struct ClipprClip: AsyncParsableCommand {

    static let configuration = CommandConfiguration(commandName: "clip")

    mutating func run() async throws {

        guard let token = TokenManager.getCurrentConfig() else {
            let err = "Config invalid: run clippr token status"
            if let data = (err + "\n").data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            throw ExitCode.failure
        }

        do {
            let x = try await Connection.fetchData(from: "https://" + token.server + "/api/clipboard", token: token.token)
            print(x)
        } catch {
            let err = "Something went wrong :/"
            if let data = (err + "\n").data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            throw ExitCode.failure
        }
        
    }
}