//
//  AppDelegate.swift
//  Continuous
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit
import ContinuousKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let networkService: NetworkService = StandardNetworkService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = BranchesRouter().build(networkService: networkService)
        window?.makeKeyAndVisible()

        return true
    }
}

