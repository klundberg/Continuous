//
//  BranchesPresenter.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit
import ContinuousKit

class BranchesPresenter {
    var interactor: BranchesInteractor?
    var router: BranchesRouter?

    weak var controller: BranchesViewController?

    func loadContent() {
        interactor?.requestData()
    }

    func presentData(branches: [Branch]) {
        controller?.branches = branches.map { branch in
            return BranchViewModel(name: branch.name)
        }
    }
}
