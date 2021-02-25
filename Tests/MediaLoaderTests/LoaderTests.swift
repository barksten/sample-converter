
import ComposableArchitecture
@testable import MediaLoader
import XCTest

class LoaderTests: XCTestCase {
    
    var env: LoaderEnvironment!

    override func setUpWithError() throws {
        env = .live
    }

    override func tearDownWithError() throws {
        env = nil
    }
        
    func testLoad() {        
        let store = TestStore(
            initialState: Loader(),
            reducer: loaderReducer.debug(),
            environment: env
        )
        
        store.assert([
            .send(.load(file: "test")),
        ])
    }
}
