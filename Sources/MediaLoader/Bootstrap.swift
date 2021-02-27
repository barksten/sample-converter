
import ComposableArchitecture

public struct Bootstrap {
    public static func start(with url: URL, dump: Bool, verbose: Bool) {
        let store = Store(
            initialState: Loader(verbose: verbose),
            reducer: loaderReducer.debug(),
            environment: .live
        )
        let viewStore = ViewStore(store)
        viewStore.send(.load(url))
        if dump {
            viewStore.send(.dumpAsset)
        }
    }
}
