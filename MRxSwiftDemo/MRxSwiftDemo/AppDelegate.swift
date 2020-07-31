//
//  AppDelegate.swift
//  MRxSwiftDemo
//
//  Created by mal on 2020/6/10.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

@_exported import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        if let window = self.window {
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
        return true
    }
}

