import ArgumentParser
import Noora

struct ClipprTokenUnselect: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "unselect")

    mutating func run() {
        let noora = Noora()


        let data = TokenManager.read()

        guard var data else {
            noora.error("Could not read data")
            return
        }

        data.active = nil

        let success = TokenManager.write(data)

        if success 
        {
            noora.success("Unselected active config")
        }
        else
        {
            noora.error("Save failed :/")
        } 
    }

}