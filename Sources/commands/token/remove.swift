import ArgumentParser
import Noora

struct ClipprTokenRemove : ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "remove", aliases: ["rm"])

    @Argument
    var ids: [String]

    mutating func run() {
        let noora = Noora()

        let data = TokenManager.read()

        guard var data else {
            noora.error("Could not read data")
            return
        }

        var warnings: [String] = []

        for id in ids {
            let x = data.tokens.removeValue(forKey: id)
            if x == nil {
                warnings.append(id)
            }
        }
        
        let success = TokenManager.write(data)

        if success 
        {
            if warnings.isEmpty {
                noora.success("Removed configs")
            } else {
                noora.warning(warnings.map { s in
                    WarningAlert(stringLiteral: s)
                })
            }
        }
        else
        {
            noora.error("Save failed :/")
        } 
    }
}