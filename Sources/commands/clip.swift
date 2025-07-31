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

        let urlString = "https://" + token.server + "/api/clipboard"

        // Validate URL
        guard let url = URL(string: urlString) else {
            let err = "Config invalid: URL invalid: run clippr token status"
            if let data = (err + "\n").data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            throw ExitCode.failure
        }

        if isatty(STDIN_FILENO) == 0 {
            try await push(to: url, with: token.token)
        } else {
            try await pull(from: url, with: token.token) 
        }
        
    }

    func pull(from url: URL, with token: String) async throws {
        do {
            let x = try await Connection.fetchData(from: url, token: token)
            print(x)
        } catch {
            let err = "Something went wrong :/"
            if let data = (err + "\n").data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            throw ExitCode.failure
        }
    }


    func push(to url: URL, with token: String) async throws {
        do {
            // Read from standard input
            let inputData = FileHandle.standardInput.readDataToEndOfFile()

            // Convert to string
            guard let inputString = String(data: inputData, encoding: .utf8) else {
                throw ExitCode.failure
            }
            try await Connection.uploadData(to: url, token: token, text: inputString)
            
        } catch {
            let err = "Something went wrong :/"
            if let data = (err + "\n").data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            throw ExitCode.failure
        }
    }
}