import XCTest
@testable import Continuous

class ContinuousTests: XCTestCase {

    func testGetData() {
        let exp = expectation(description: "blah")

        let api = BuddyBuildAPI()
        api.request(appsRequest()) { (result) in
            guard case let .value(value) = result else {
                return
            }

            dump(value)
            api.request(branchesRequest(appId: value[0].id)) { (result) in
                guard case let .value(branches) = result else {
                    return
                }
                dump(branches)
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 10)
    }


    static var allTests = [
        ("testGetData", testGetData),
    ]
}
