import XCTest
@testable import ContinuousKit

class ContinuousKitTests: XCTestCase {

    func testGetData() {
        let exp = expectation(description: "blah")

        let api = NetworkService()
        api.request(BuddyBuildAPI.apps()) { (result) in
            guard case let .value(value) = result else {
                return
            }

            dump(value)
            api.request(BuddyBuildAPI.branches(appId: value[0].id)) { (result) in
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
