//
//  AppDelegate.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/7.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit
@_exported import SnapKit

func AILog(_ input: Any..., file: String = #file, function: String = #function, line:Int = #line) {
    #if DEBUG
    var fileName = file
    let fileNameArray = file.components(separatedBy: "/")
    if let f = fileNameArray.last {
        fileName = f
    }
    print("<file: \(fileName)> <func: \(function)> <line: \(line)>: \(input)")
    #else
    #endif
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AIRouterManager.registerRouters()
        return true
    }
}

