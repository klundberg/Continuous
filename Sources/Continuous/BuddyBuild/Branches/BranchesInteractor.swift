//
//  BranchesInteractor.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import Foundation
import ContinuousKit

class BranchesInteractor {
    var networkService: NetworkService

    weak var presenter: BranchesPresenter?

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func requestData() {
        networkService.request(BuddyBuildAPI.apps()) { (result) in
            guard case let .value(apps) = result else { return }
            self.networkService.request(BuddyBuildAPI.branches(appId: apps[0].id), completion: { (result) in
                guard case let .value(branches) = result else { return }
                DispatchQueue.main.async {
                    self.presenter?.presentData(branches: branches)
                }
            })
        }
    }
}
