import ArgumentParser
import Noora

struct ClipprTokenUpdate: ParsableCommand {
    
    static let configuration = CommandConfiguration(commandName: "update")
    
    @Argument
    var id: String?

    @Argument
    var token: String?

    mutating func run() throws {

        let noora = Noora()

        var data = try CommandHelper.getSettings(noora)

        if id == nil {
            id = noora.singleChoicePrompt(
                title: "Config selection",
                question: "Which id should be used?",
                options: Array(data.tokens.keys),
                description: "The id of which the token should be changed",
            )
        }

        if token == nil {
            token = noora.textPrompt(
                title: "Token",
                prompt: "Enter the new token",
                description: "To auth you",
                collapseOnAnswer: true
            )
        }

        guard let id, let token else {
            
            noora.error("Something went wrong :/")
            throw ExitCode.failure
        }

        guard var config = data.tokens[id] else {
            noora.error("The passed id does not exist")
            throw ExitCode.failure
        }

        config.token = token

        data.tokens[id] = config

        try CommandHelper.setSettings(noora, data)

        noora.success("Updated token")
    }
}