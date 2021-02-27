
import ComposableArchitecture
import AVFoundation

struct AssetLoaderError: Error, Equatable {}

struct Loader: Equatable {
    var verbose: Bool = false
    var asset: AVAsset?
}

enum LoaderAction: Equatable {
    case dumpAsset
    case load(URL)
    case loadingResult(Result<AVURLAsset, AssetLoaderError>)
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
        state.asset = asset
        return environment.printer("Media loaded: \(asset.description)")
            .fireAndForget()
        
    case let .loadingResult(.failure(error)):
        return environment.printer("Load error: \(error.localizedDescription)")
            .fireAndForget()
    
    case .dumpAsset:
        guard let asset = state.asset else {
            return environment.printer("Couldn't dump; No media loaded").fireAndForget()
        }
        let duration = asset.duration
        return environment.printer("\(asset.description), Duration: \(duration)")
            .fireAndForget()
    }
}
