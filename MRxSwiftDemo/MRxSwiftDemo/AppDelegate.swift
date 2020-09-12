//
//  AppDelegate.swift
//  MRxSwiftDemo
//
//  Created by mal on 2020/6/10.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

@_exported import RxSwift
@_exported import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        if let window = self.window {
            let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavi")
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
        return true
    }
}

