
import AVFoundation
import ComposableArchitecture

#if DEBUG
extension LoaderEnvironment {
    static let mock: Self = .init(
        printer: { string in
            .fireAndForget {
                print(string)
            }
        },
        loader: { _ in fatalError() }
    )
}
#endif

extension LoaderEnvironment {
    public static let live: Self = .init(
        printer: { string in
            .fireAndForget {
                print(string)
            }
        },
        loader: { url in
            Effect.future { completion in
                let asset = AVURLAsset(url: url)
                guard asset.isReadable else {
                    completion(.failure(AssetLoaderError()))
                    return
                }
                completion(.success(asset))
            }
        }
    )
}
