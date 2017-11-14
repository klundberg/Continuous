//: Playground - noun: a place where people can play

import UIKit
import ContinuousKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let api = BuddyBuild(key: BuddyBuild.key)

api.getApps { result in
    guard case let .value(apps) = result else { PlaygroundPage.current.finishExecution() }
    dump(apps)

    guard let wayfairApp = apps.first(where: { $0.name == "Wayfair" }) else {
        PlaygroundPage.current.finishExecution() }

    api.getBuilds(for: wayfairApp) { result2 in
        defer {
            PlaygroundPage.current.finishExecution()
        }

        do {
            let builds: [Build] = try result2.materialize()
            dump(builds)
        } catch {
            print(error)

        }
    }
}

