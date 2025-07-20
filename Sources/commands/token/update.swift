import ArgumentParser
import Noora

struct ClipprTokenUpdate: ParsableCommand {
    
    static let configuration = CommandConfiguration(commandName: "update")
    
    @Argument
    var id: String?

    @Argument
    var token: String?

    mutating func run() {

        let noora = Noora()

        let data = TokenManager.read()

        guard var data else {
            noora.error("Could not read data")
            return
        }

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
            return
        }

        guard var config = data.tokens[id] else {
            noora.error("The passed id does not exist")
            return
        }

        config.token = token

        data.tokens[id] = config

        let success = TokenManager.write(data)

        if success 
        {
            noora.success("Updated token")
        }
        else
        {
            noora.error("Save failed :/")
        } 
    }
}