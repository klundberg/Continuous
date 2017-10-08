//
//  AppRouter.swift
//  Continuous
//
//  Created by Kevin Lundberg on 10/8/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit
import ContinuousKit

class AppRouter {
    func start(in screen: UIScreen, networkService: NetworkService) -> UIWindow {
        let window = UIWindow(frame: screen.bounds)
        window.backgroundColor = .white
        window.rootViewController = BranchesRouter().build(networkService: networkService)
        window.makeKeyAndVisible()
        return window
    }
}
