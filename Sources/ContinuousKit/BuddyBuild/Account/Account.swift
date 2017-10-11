//
//  Account.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 10/8/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import Foundation
import Security

public struct APIKey: Codable {
    var key: String

    public init(key: String) {
        self.key = key
    }
}

extension APIKey: CustomStringConvertible {
    public var description: String {
        return key
    }
}
