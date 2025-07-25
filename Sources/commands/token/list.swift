import ArgumentParser
import Noora

struct ClipprTokenList: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "list", aliases: ["ls"])

    @Flag(name: [.long, .short], help: "include token in table")
    var all = false

    mutating func run() throws {

        let noora = Noora()


        let data = try CommandHelper.getSettings(noora)

        if all {

            noora.table(
                headers: ["Id", "Domain", "Token"],
                rows: data.tokens.map { (key: String, value: Config) in
                    [key, value.server, value.token]
                }
                
            )

        } else {

             noora.table(
                headers: ["Id", "Domain"],
                rows: data.tokens.map { (key: String, value: Config) in
                    [key, value.server]
                }
                
            ) 
        }
    }
}