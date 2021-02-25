
import ComposableArchitecture

struct Loader: Equatable {
    
}

enum LoaderAction: Equatable {
    case load(file: String)
}

struct LoaderEnvironment {
    var printer: (String) -> Effect<Never, Never>
}

let loaderReducer = Reducer<Loader, LoaderAction, LoaderEnvironment> { state, action, environment in
    switch action {
    case let .load(file: file):
        return environment.printer(file).fireAndForget()
    }
}
