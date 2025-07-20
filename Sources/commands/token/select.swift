import ArgumentParser
import Noora

struct ClipprTokenSelect: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "select")

    @Argument
    var id: String?

    mutating func run() {
        let noora = Noora()

        let data = TokenManager.read()

        guard var data else {
            noora.error("Could not read data")
            return
        }

        let options = Array(data.tokens.keys)

        guard !options.isEmpty else {
            noora.error("There are no configs")
            noora.info("Run clippr token add")
            return
        }

        if id == nil {
            id = noora.singleChoicePrompt(
                title: "Config selection",
                question: "Which id should be used?",
                options: options,
                description: "The id of the config to auth you",
            )
        }

        guard let id else {
            noora.error("No id selected")
            return 
        }

        data.active = id

        let success = TokenManager.write(data)

        if success 
        {
            noora.success("Changed active config")
        }
        else
        {
            noora.error("Save failed :/")
        }        
    }
}