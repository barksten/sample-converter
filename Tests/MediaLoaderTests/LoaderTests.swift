
import AVFoundation
import Combine
import ComposableArchitecture
@testable import MediaLoader
import XCTest

class LoaderTests: XCTestCase {
    
    var env: LoaderEnvironment!
    var result: AVURLAsset!

    override func setUpWithError() throws {
        result = AVURLAsset(url: URL(string: "test://")!)
        env = .mock
    }

    override func tearDownWithError() throws {
        env = nil
    }
        
    func testLoadSuccess() {
        env.loader = { _ in
            Just(self.result)
                .setFailureType(to: AssetLoaderError.self)
                .eraseToEffect()
        }
        let store = TestStore(
            initialState: Loader(),
            reducer: loaderReducer.debug(),
            environment: env
        )
        let url = result.url
        
        store.assert([
            .send(.load(url)),
            .receive(.loadingResult(.success(result)))
        ])
    }
    
    func testLoadError() {
        env.loader = { _ in
            Fail(error: AssetLoaderError())
                .eraseToEffect()
        }
        let store = TestStore(
            initialState: Loader(),
            reducer: loaderReducer.debug(),
            environment: env
        )
        
        store.assert([
            .send(.load(URL(string: "test://")!)),
            .receive(.loadingResult(.failure(AssetLoaderError())))
        ])
    }
}
