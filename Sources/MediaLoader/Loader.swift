
import ComposableArchitecture
import AVFoundation

struct AssetLoaderError: Error, Equatable {}

struct Loader: Equatable {
    
}

enum LoaderAction: Equatable {
    case loadingResult(Result<AVURLAsset, AssetLoaderError>)
    case load(URL)
}

struct LoaderEnvironment {
    var printer: (String) -> Effect<Never, Never>
    var loader: (URL) -> Effect<AVURLAsset, AssetLoaderError>
}

let loaderReducer = Reducer<Loader, LoaderAction, LoaderEnvironment> { state, action, environment in
    switch action {
    case let .load(url):
        return environment.loader(url)
            .catchToEffect()
            .map(LoaderAction.loadingResult)

    case let .loadingResult(.success(asset)):
        return environment.printer(asset.description)
            .fireAndForget()
    
    case let .loadingResult(.failure(error)):
        return environment.printer("Load error: \(error.localizedDescription)")
            .fireAndForget()
    }
}
