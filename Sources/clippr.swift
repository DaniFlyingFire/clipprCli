import ArgumentParser

@main
struct Clippr: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        subcommands: [ClipprClip.self, ClipprToken.self, ClipprTokenStatus.self],
        defaultSubcommand: ClipprClip.self
    )
}