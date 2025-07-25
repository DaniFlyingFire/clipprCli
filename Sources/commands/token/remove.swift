import ArgumentParser
import Noora

struct ClipprTokenRemove : ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "remove", aliases: ["rm"])

    @Argument
    var ids: [String]

    mutating func run() throws {
        let noora = Noora()

        var data = try CommandHelper.getSettings(noora)

        var warnings: [String] = []

        for id in ids {
            let x = data.tokens.removeValue(forKey: id)
            if x == nil {
                warnings.append(id)
            }
        }
        
        try CommandHelper.setSettings(noora, data)


        if warnings.isEmpty {
            noora.success("Removed configs")
        } else {
            noora.warning(warnings.map { s in
                WarningAlert(stringLiteral: s)
            })
        }
        
    }
}