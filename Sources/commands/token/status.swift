import ArgumentParser
import Noora

struct ClipprTokenStatus: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "status")

    mutating func run() {
        let noora = Noora()


        let data = TokenManager.read()

        guard let data else {
            noora.error("Could not read data")
            return
        }

        guard let active = data.active else {

            let warning = WarningAlert.alert("currently no active config", takeaway: "run clippr token select")

            noora.warning(warning)
            return
        }

        noora.info("\"\(active)\" is currently active")

        guard let config = data.tokens[active] else {

            let warning = WarningAlert.alert("the active config does not exist any more", takeaway: "run clippr token unselect or clippr token add")

            noora.warning(warning)
            return
        }

        noora.info("It uses the domain \"\(config.server)\"")

    }
}