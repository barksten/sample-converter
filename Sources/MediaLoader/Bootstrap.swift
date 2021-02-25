
import ComposableArchitecture

public struct Bootstrap {
    public static func start(with url: URL) {
        let store = Store(
            initialState: Loader(),
            reducer: loaderReducer,
            environment: .live
        )
        let viewStore = ViewStore(store)
        viewStore.send(.load(url))
    }
}
