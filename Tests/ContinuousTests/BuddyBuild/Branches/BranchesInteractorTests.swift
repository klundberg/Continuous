//
//  BranchesInteractorTests.swift
//  ContinuousKitTests
//
//  Created by Kevin Lundberg on 10/1/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import XCTest
import ContinuousKit
@testable import Continuous

private func ~=(lhs: Any.Type, rhs: Any.Type) -> Bool {
    return lhs == rhs
}

class BranchesInteractorTests: XCTestCase {

    class MockNetworkService: NetworkService {
        private func result<Response>(_ value: Any) -> Result<Response> {
            return Result.value(value as! Response)
        }

        var requestsMade: [(URL, Any)] = []

        func request<Response>(_ request: Request<Response>, completion: @escaping (Result<Response>) -> ()) {
            let completion2 = { (result: Result<Response>) in
                self.requestsMade.append((request.url, result))
                completion(result)
            }

            switch Response.self {
            case [App].self:
                completion2(result([
                    App(id: "1", name: "one", platform: .ios),
                    App(id: "2", name: "two", platform: .ios),
                    ]))
            case [Branch].self:
                completion2(result([
                    Branch(name: "branch1"),
                    ]))
            default:
                break
            }

        }
    }

    var interactor: BranchesInteractor!
    var networkService: MockNetworkService!

    override func setUp() {
        super.setUp()

        networkService = MockNetworkService()
        interactor = BranchesInteractor(networkService: networkService)
    }

    func testLoadsAppsFirst() {
        interactor.requestData()

        XCTAssertEqual(networkService.requestsMade[0].0,
                       URL(string: "https://api.buddybuild.com/v1/apps")!)
    }

    func testBranchesLoadFromFirstAppByDefault() {
        interactor.requestData()

        XCTAssertEqual(networkService.requestsMade[1].0,
                       URL(string: "https://api.buddybuild.com/v1/apps/1/branches")!)
    }
}
