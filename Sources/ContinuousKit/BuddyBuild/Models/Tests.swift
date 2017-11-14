//
//  Tests.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 10/11/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

public struct TestFilter: QueryParameterConvertible {
    var showFailed: Bool
    var showPassing: Bool

    public func queryParameters() -> [String : String] {
        return [
            "showFailed": "\(showFailed)",
            "showPassing": "\(showPassing)"
        ]
    }
}

public struct TestResults: SnakeCaseCodable {
    public let buildId: String
    public let tests: [Test]
}

public struct Test: SnakeCaseCodable {
    public let run: String
    public let target: String
    public let suite: String
    public let name: String
    public let status: String
}
