import ArgumentParser

struct ClipprToken: ParsableCommand {

    static let configuration = CommandConfiguration(
        commandName: "token",
        subcommands: [ClipprTokenAdd.self, ClipprTokenSelect.self, ClipprTokenList.self, ClipprTokenRemove.self, ClipprTokenStatus.self, ClipprTokenUnselect.self, ClipprTokenUpdate.self],
    )
}