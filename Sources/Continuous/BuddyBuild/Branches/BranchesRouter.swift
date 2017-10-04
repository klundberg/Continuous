//
//  BranchesRouter.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit
import ContinuousKit

class BranchesRouter {
    func build(networkService: NetworkService) -> UIViewController {
        let interactor = BranchesInteractor(networkService: networkService)

        let presenter = BranchesPresenter()
        presenter.interactor = interactor
        presenter.router = self

        interactor.presenter = presenter

        let vc = BranchesViewController()
        vc.presenter = presenter

        presenter.controller = vc

        return vc
    }
}
