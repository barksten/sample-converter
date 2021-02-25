import ArgumentParser
import Foundation
import MediaLoader

struct SampleConverter: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Verbose.")
    var verbose = false

    @Argument(help: "File.")
    var file: String
    
    mutating func run() throws {
        Bootstrap.start(with: URL(string: file)!)
    }
}

SampleConverter.main()

