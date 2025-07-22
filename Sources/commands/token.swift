import ArgumentParser

struct ClipprToken: ParsableCommand {

    static let configuration = CommandConfiguration(
        commandName: "token",
        abstract: "A set of commands for managing the auth tokens",
        subcommands: [ClipprTokenAdd.self, ClipprTokenSelect.self, ClipprTokenList.self, ClipprTokenRemove.self, ClipprTokenStatus.self, ClipprTokenUnselect.self, ClipprTokenUpdate.self],
    )
}