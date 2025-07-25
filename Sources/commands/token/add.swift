import ArgumentParser
import Noora

struct ClipprTokenAdd: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "add")

    @Option
    var id: String?

    @Option
    var domain: String?

    @Option
    var token: String?

    mutating func run() throws {

        let noora = Noora()

        var data = try CommandHelper.getSettings(noora)

        if domain == nil 
        {
            domain = noora.textPrompt(
                title: "Domain",
                prompt: "Please enter the clippr domain",
                description: "The server URL to pull and push data",
                collapseOnAnswer: true
            )
        }

        if token == nil 
        {
            token = noora.textPrompt(
                title: "Token",
                prompt: "Please enter the clippr token",
                description: "To auth you",
                collapseOnAnswer: true
            )
        }

        if id == nil 
        {
            let tempId = noora.textPrompt(
                title: "Id",
                prompt: "Please a name (id) for the clippr instance (empty -> use domain)",
                description: "A name to easily switch instances",
                collapseOnAnswer: true
            )

            if tempId == "" 
            {
                id = domain
            } 
            else 
            {
                id = tempId
            }
        }

        guard let id, let domain, let token else {
            noora.error("Something went wrong :/")
            throw ExitCode.failure
        }

        data.tokens[id] = Config(server: domain, token: token)

        try CommandHelper.setSettings(noora, data)

        noora.success("Added new server")
    }
}