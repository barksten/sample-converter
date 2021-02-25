
import ComposableArchitecture

extension LoaderEnvironment {
    public static let live: Self = .init { string in
        .fireAndForget {
            print(string)
        }
    }
}
