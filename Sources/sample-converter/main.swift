import ArgumentParser
import Foundation
import MediaLoader

struct SampleConverter: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Verbose.")
    var verbose = false

    @Argument(help: "File.")
    var file: String
    
    mutating func run() throws {
        Bootstrap.start(with: URL(fileURLWithPath: file, isDirectory: false))
    }
}

SampleConverter.main()

