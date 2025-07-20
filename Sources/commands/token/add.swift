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

    mutating func run() {

        let noora = Noora()

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
            return
        }

        let data = TokenManager.read()

        guard var data else {
            noora.error("Could not read data")
            return
        }

        data.tokens[id] = Config(server: domain, token: token)

        let success = TokenManager.write(data)

        if success 
        {
            noora.success("Added new server")
        }
        else
        {
            noora.error("Save failed :/")
        }
    }
}