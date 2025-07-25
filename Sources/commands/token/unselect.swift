import ArgumentParser
import Noora

struct ClipprTokenUnselect: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "unselect")

    mutating func run() throws{
        let noora = Noora()


        var data = try CommandHelper.getSettings(noora)

        data.active = nil

        try CommandHelper.setSettings(noora, data)

        noora.success("Unselected active config")
        
    }

}